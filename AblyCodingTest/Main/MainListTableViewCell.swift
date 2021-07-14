//
//  MainListCollectionViewCell.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit

class MainListTableViewCell: UITableViewCell {
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    var discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.watermelonColor
        label.text = "0%"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.sizeToFit()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = AppColor.darkTextColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = AppColor.lightTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "imgBadgeNew")
        return imageView
    }()
    
    var purchaseCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.lightTextColor
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // MARK: UI 만들기
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        [thumbnailImageView,discountLabel,priceLabel,descriptionLabel,newImageView,purchaseCountLabel].forEach {
            addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(16)
            $0.width.height.equalTo(80)
            $0.bottom.lessThanOrEqualTo(-20)
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(24)
            $0.left.equalTo(thumbnailImageView.snp.right).offset(12)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(discountLabel)
            $0.left.equalTo(discountLabel.snp.right).offset(5)
            $0.right.equalTo(snp.right).offset(-22)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.bottom).offset(5)
            $0.left.equalTo(discountLabel.snp.left)
            $0.right.equalTo(snp.right).offset(-22)
            
            $0.bottom.lessThanOrEqualTo(snp.bottom).offset(-24)
        }
        
        newImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.left.equalTo(discountLabel.snp.left)
            $0.width.equalTo(34)
            $0.height.equalTo(17)
            $0.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        purchaseCountLabel.snp.makeConstraints {
            $0.left.equalTo(newImageView.snp.right).offset(5)
            $0.centerY.equalTo(newImageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     할인율 가지고 오기
     */
    func getDiscountPercent(actualPrice: Int, price: Int) -> Int {
        let percent = 100 - ((Float(price) / Float(actualPrice)) * 100)
        return Int(percent)
    }
    
    func setData(model: ListModel.Goods) {
        if model.image == "" {
            thumbnailImageView.image = UIImage.init(systemName: "exclamationmark")
        } else {
            thumbnailImageView.sd_setImage(with: URL(string: model.image ?? ""), placeholderImage: UIImage(systemName: "exclamationmark"))
        }
        descriptionLabel.text = model.name
        let discountPercent = getDiscountPercent(actualPrice: model.actual_price ?? 0, price: model.price ?? 0)
        discountLabel.text = "\(discountPercent)%"
        discountLabel.isHidden = discountPercent == 0 ? true : false
        
        // 할인율이 0인 경우 처리
        priceLabel.snp.remakeConstraints {
            $0.centerY.equalTo(discountLabel)
            if discountPercent == 0 {
                $0.left.equalTo(thumbnailImageView.snp.right).offset(12)
            } else {
                $0.left.equalTo(discountLabel.snp.right).offset(5)
            }
            $0.right.equalTo(snp.right).offset(-22)
        }
        priceLabel.text = "\(Utils.getCommaNumber(model.price ?? 0))"
        newImageView.isHidden = model.is_new ?? false ? false : true
        
        // new 표시 없는 경우
        purchaseCountLabel.snp.remakeConstraints {
            if model.is_new ?? false {
                $0.left.equalTo(newImageView.snp.right).offset(5)
            } else {
                $0.left.equalTo(discountLabel.snp.left)
            }
            $0.centerY.equalTo(newImageView)
        }
        
        purchaseCountLabel.text = "\(Utils.getCommaNumber(model.sell_count ?? 0) )개 구매중"
        purchaseCountLabel.isHidden = model.sell_count ?? 0 < 10 ? true : false
        
        //테스트
//        newImageView.isHidden = true
//        purchaseCountLabel.isHidden = true
        
        // new , 구매 카운트 히든일 경우
        newImageView.snp.remakeConstraints {
            if purchaseCountLabel.isHidden && newImageView.isHidden {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
                $0.left.equalTo(discountLabel.snp.left)
                $0.width.equalTo(34)
                $0.height.equalTo(17)
            } else {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
                $0.left.equalTo(discountLabel.snp.left)
                $0.width.equalTo(34)
                $0.height.equalTo(17)
                $0.bottom.equalTo(snp.bottom).offset(-24)
            }
        }
    }
}
