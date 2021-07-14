//
//  ViewController.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import RxSwift
import RxCocoa

class MainListViewController: UIViewController {

    let mainListView = MainLitView()
    let mainListViewModel = MainListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainListView)
        setBinding()
        mainListView.setLayout()
//        mainListView.thumbNailCollectionView.delegate = self
        mainListView.bannerCollectionView.dataSource = self
        mainListView.listTableView.dataSource = self
        mainListViewModel.configure()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainListView.layoutUpdateBannerCollectionView()
    }
    
    func setBinding() {
        //리스트 불러오기
        mainListViewModel.listSuccess.bind(onNext: {[weak self] in
            self?.mainListView.bannerCollectionView.reloadData()
            self?.mainListView.listTableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDataSource 델리게이트
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

// MARK: - UICollectionViewDataSource 델리게이트
extension MainListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainListViewModel.getListItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        let model = mainListViewModel.getListItem(index: indexPath.row)
        listCell.setData(model: model)
        return listCell
    }
    
    
}

