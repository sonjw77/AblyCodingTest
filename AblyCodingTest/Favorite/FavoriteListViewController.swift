//
//  FavoriteListViewController.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit

class FavoriteListViewController: UIViewController {

    let favoriteListView = FavoriteListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoriteListView)
        favoriteListView.setLayout()
        favoriteListView.listTableView.dataSource = self
        favoriteListView.listTableView.reloadData()
        
        NotificationCenter.default.addObserver(self as Any,
                                               selector: #selector(reloadTableView(_:)),
                                               name: NSNotification.Name("changeFavoriteList"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "좋아요"
    }
    
    
   @objc func reloadTableView(_ notification: Notification) {
        favoriteListView.listTableView.reloadData()
   }
}

// MARK: - UITableViewDataSource
extension FavoriteListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SaveManager.sharedInstance().getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        let model = SaveManager.sharedInstance().getItem(index: indexPath.row)
        listCell.setData(model: model, isShowFavoriteButton: false)
        return listCell
    }
}
