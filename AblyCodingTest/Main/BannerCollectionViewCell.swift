//
//  BannerCollectionViewCell.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: UI 만들기
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(url: String) {
        if url == "" {
            imageView.image = UIImage.init(systemName: "exclamationmark")
        } else {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "exclamationmark"))
        }
    }
}
