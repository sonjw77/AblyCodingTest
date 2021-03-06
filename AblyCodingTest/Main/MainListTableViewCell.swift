//
//  MainListCollectionViewCell.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit
import RxSwift

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
    
    var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "iconZzim"), for: .normal)
        button.setImage(UIImage(named: "iconZzimActive"), for: .selected)
        return button
    }()
    
    var seperateLineView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.lightTextColor
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    /**
     init ??? UI ??????
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        [thumbnailImageView,discountLabel,priceLabel,descriptionLabel,newImageView,purchaseCountLabel,favoriteButton,seperateLineView].forEach {
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
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top).offset(8)
            $0.right.equalTo(thumbnailImageView.snp.right).offset(-8)
            $0.width.height.equalTo(24)
        }
        
        seperateLineView.snp.makeConstraints {
            $0.bottom.equalTo(snp.bottom)
            $0.left.right.equalTo(self)
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    /**
     ????????? ????????? ??????
     */
    func getDiscountPercent(actualPrice: Int, price: Int) -> Int {
        let percent = 100 - ((Float(price) / Float(actualPrice)) * 100)
        return Int(percent)
    }
    
    /**
     ????????? ??????
     */
    func setData(model: ListModel.Goods, isShowFavoriteButton: Bool) {
        if model.image == "" {
            thumbnailImageView.image = UIImage.init(systemName: "exclamationmark")
        } else {
            thumbnailImageView.sd_setImage(with: URL(string: model.image ?? ""), placeholderImage: UIImage(systemName: "exclamationmark"))
        }
        descriptionLabel.text = model.name
        let discountPercent = getDiscountPercent(actualPrice: model.actual_price ?? 0, price: model.price ?? 0)
        discountLabel.text = "\(discountPercent)%"
        discountLabel.isHidden = discountPercent == 0 ? true : false
        
        // ???????????? 0??? ?????? ??????
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
        
        // new ?????? ?????? ??????
        purchaseCountLabel.snp.remakeConstraints {
            if model.is_new ?? false {
                $0.left.equalTo(newImageView.snp.right).offset(5)
            } else {
                $0.left.equalTo(discountLabel.snp.left)
            }
            $0.centerY.equalTo(newImageView)
        }
        
        purchaseCountLabel.text = "\(Utils.getCommaNumber(model.sell_count ?? 0) )??? ?????????"
        purchaseCountLabel.isHidden = model.sell_count ?? 0 < 10 ? true : false
        
        //?????????
//        newImageView.isHidden = true
//        purchaseCountLabel.isHidden = true
        
        // new , ?????? ????????? ????????? ??????
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
        favoriteButton.isHidden = isShowFavoriteButton ? false : true
        favoriteButton.isSelected = SaveManager.sharedInstance().isExistItem(id: model.id ?? 0)
    }
    
    /**
     ?????? ?????? ????????? ?????? ??????
     */
    func changeFavoriteButton(_ isSelect: Bool) {
        favoriteButton.isSelected = isSelect
        UIView.animate(withDuration: 0.2, animations: {
            self.favoriteButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: {(_) in
            self.favoriteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}
