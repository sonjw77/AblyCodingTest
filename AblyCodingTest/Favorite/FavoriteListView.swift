//
//  FavoriteListView.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/16.
//

import UIKit

class FavoriteListView: UIView {

    var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainListTableViewCell.self, forCellReuseIdentifier: "MainListTableViewCell")
        return tableView
    }()
    
    func setLayout() {
        snp.makeConstraints {
            $0.top.equalTo(Utils.getSafeLayoutInsets().top)
            $0.bottom.left.right.equalTo(superview!)
        }
        addSubview(listTableView)
        listTableView.separatorStyle = .none
        listTableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
        }
    }
}
