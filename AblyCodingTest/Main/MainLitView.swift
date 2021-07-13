//
//  MainLitView.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import SnapKit

class MainLitView: UIView {
    
    private let thumbNailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = AppColor.mainColor
        return collectionView
    }()
    
    private let listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    func setLayout() {
        snp.makeConstraints {
            $0.top.equalTo(Utils.getSafeLayoutInsets().top)
            $0.bottom.left.right.equalTo(superview!)
        }
        backgroundColor = .yellow
        
        [listCollectionView].forEach({
            addSubview($0)
        })
        listCollectionView.addSubview(thumbNailCollectionView)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Utils.getDisplayWidth(), height: 200)
        layout.scrollDirection = .horizontal
        thumbNailCollectionView.collectionViewLayout = layout
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: Utils.getDisplayWidth(), height: Utils.getDisplayHeight())
        listCollectionView.collectionViewLayout = layout2
        
        
        listCollectionView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
        }
        
//        thumbNailCollectionView.delegate = self
        thumbNailCollectionView.dataSource = self
        thumbNailCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        thumbNailCollectionView.snp.makeConstraints {
            $0.left.right.equalTo(self)
            $0.width.equalTo(Utils.getDisplayWidth())
            $0.height.equalTo(200)
        }
    }
}

// MARK: - UICollectionViewDataSource 델리게이트
extension MainLitView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        return listCell
    }
}
