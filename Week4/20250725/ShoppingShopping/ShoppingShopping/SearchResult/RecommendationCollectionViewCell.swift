//
//  RecommendationCollectionViewCell.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class RecommendationCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "RecommendationCollectionViewCell"
    
    let recommendImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ConstraintValue.CornerRadius.button
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.Body.regular13
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(recommendImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        recommendImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.height.equalTo(contentView.snp.width)
            make.top.equalTo(contentView.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendImageView.snp.bottom).offset(ConstraintValue.CollectionView.itemQuantity)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
