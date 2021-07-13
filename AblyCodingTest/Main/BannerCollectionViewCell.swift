//
//  BannerCollectionViewCell.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import AlamofireImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: UI 만들기
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(url: String) {
        if url == "" {
            imageView.image = UIImage.init(systemName: "exclamationmark")
        } else {
            imageView.af.setImage(withURL: URL.init(string: url)!)
        }
    }
}
