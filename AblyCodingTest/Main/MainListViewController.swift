//
//  ViewController.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class MainListViewController: UIViewController {

    let mainListView = MainLitView()
    let mainListViewModel = MainListViewModel()
    let disposeBag = DisposeBag()
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainListView)
        setBinding()
        mainListView.setLayout()
        mainListView.bannerCollectionView.delegate = self
        mainListView.bannerCollectionView.dataSource = self
        mainListView.listTableView.dataSource = self
        mainListView.listTableView.delegate = self
        mainListViewModel.configure()
        mainListView.refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "홈"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainListView.layoutUpdateBannerCollectionView()
    }
    
    func setBinding() {
        //처음 리스트 불러오기
        mainListViewModel.firstListSuccess.bind(onNext: {[weak self] in
            self?.mainListView.bannerCollectionView.reloadData()
            self?.mainListView.listTableView.reloadData()
            self?.mainListView.setBannerPositon(page: "1/\(self?.mainListViewModel.bannerList?.count ?? 1)")
            self?.mainListView.refreshControl.endRefreshing()
            self?.mainListView.bannerCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }).disposed(by: disposeBag)
        
        //다음 리스트 불러오기
        mainListViewModel.nextListSuccess.bind(onNext: {[weak self] in
            self?.mainListView.listTableView.reloadData()
            self?.isLoading = false
        }).disposed(by: disposeBag)
    }
    
    @objc func refreshList(_ sender: Any) {
        mainListViewModel.resetData()
        mainListViewModel.getFirstList()
    }
}

// MARK: - UICollectionViewDataSource
extension MainListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainListViewModel.getBannerItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        listCell.setData(url: mainListViewModel.getBannerItem(index: indexPath.row).image ?? "")
        return listCell
    }
}

// MARK: - UICollectionViewDelegate
extension MainListViewController : UICollectionViewDelegate {

}

// MARK: - UITableViewDataSource
extension MainListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainListViewModel.getListItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        let model = mainListViewModel.getListItem(index: indexPath.row)
        listCell.setData(model: model, isShowFavoriteButton: true)
        listCell.favoriteButton.rx.tap.asDriver().drive(onNext:{
            let isSelect = !listCell.favoriteButton.isSelected
            listCell.changeFavoriteButton(isSelect)
            SaveManager.sharedInstance().checkItem(model: model, isFavorite: isSelect)
        }).disposed(by: listCell.disposeBag)
        return listCell
    }
}

// MARK: - UITableViewDelegate
extension MainListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UIScrollViewDelegate 델리게이트
extension MainListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mainListView.setBannerPositon(page: "\((Int(scrollView.contentOffset.x) / Int(Utils.getDisplayWidth())) + 1)/\(mainListViewModel.bannerList?.count ?? 1)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.y) % 10 == 0 && mainListViewModel.isLastPage == false {
            if mainListView.listTableView.indexPath(for: mainListView.listTableView.visibleCells.last ?? UITableViewCell())?.row ?? 0 > ((mainListViewModel.getListItemCount() ) - 3)  && isLoading == false {
                isLoading = true
                mainListViewModel.getNextList()
            }
        }
    }
}

