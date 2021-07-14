//
//  MainLitView.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import SnapKit

class MainLitView: UIView {
    
    let bannerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = .zero
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(MainListTableViewCell.self, forCellReuseIdentifier: "MainListTableViewCell")
        return tableView
    }()
    
    func setLayout() {
        snp.makeConstraints {
            $0.top.equalTo(Utils.getSafeLayoutInsets().top)
            $0.bottom.left.right.equalTo(superview!)
        }
        addSubview(listTableView)
        listTableView.tableHeaderView = bannerCollectionView
        
        layoutUpdateBannerCollectionView()
        
        listTableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
        }
        
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        bannerCollectionView.frame = CGRect(x: 0, y: 0, width: Utils.getDisplayWidth(), height: 200)
        bannerCollectionView.snp.makeConstraints {
            $0.left.right.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
            $0.height.equalTo(200)
        }
    }
    
    /**
     배너뷰 레이아웃 갱신
     */
    func layoutUpdateBannerCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Utils.getDisplayWidth(), height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        bannerCollectionView.collectionViewLayout = layout
        DispatchQueue.main.async {
            self.bannerCollectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
        
    }
}
