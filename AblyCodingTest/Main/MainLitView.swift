//
//  MainLitView.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import SnapKit

class MainLitView: UIView {
    
    var bannerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var bannerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = .zero
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(MainListTableViewCell.self, forCellReuseIdentifier: "MainListTableViewCell")
        return tableView
    }()
    
    var bannerPageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let refreshControl = UIRefreshControl()
    
    func setLayout() {
        snp.makeConstraints {
            $0.top.equalTo(Utils.getSafeLayoutInsets().top)
            $0.bottom.left.right.equalTo(superview!)
        }
        addSubview(listTableView)
        listTableView.tableHeaderView = bannerView
        listTableView.refreshControl = refreshControl
        bannerView.frame = CGRect(x: 0, y: 0, width: Utils.getDisplayWidth(), height: Utils.getDisplayWidth() * CGFloat(0.7))
        layoutUpdateBannerCollectionView()
        
        listTableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
        }
        
        bannerView.addSubview(bannerCollectionView)
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        bannerCollectionView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(bannerView)
        }
        
        bannerView.addSubview(bannerPageLabel)
        bannerPageLabel.snp.makeConstraints {
            $0.bottom.equalTo(bannerCollectionView.snp.bottom).offset(-16)
            $0.right.equalTo(bannerCollectionView.snp.right).offset(-16)
            $0.width.equalTo(48)
            $0.height.equalTo(24)
        }
    }
    
    /**
     배너뷰 레이아웃 갱신
     */
    func layoutUpdateBannerCollectionView() {
        bannerView.frame = CGRect(x: 0, y: 0, width: Utils.getDisplayWidth(), height: Utils.getDisplayWidth() * CGFloat(0.7))
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Utils.getDisplayWidth(), height: Utils.getDisplayWidth() * CGFloat(0.7))
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        bannerCollectionView.collectionViewLayout = layout
        DispatchQueue.main.async {
            self.bannerCollectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
    }
    
    /**
     현재 배너의 포지션 위치 label 설정
     */
    func setBannerPositon(page: String) {
        bannerPageLabel.text = page
    }
}
