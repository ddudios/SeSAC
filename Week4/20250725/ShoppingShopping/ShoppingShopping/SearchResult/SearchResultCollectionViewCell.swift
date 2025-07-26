//
//  SearchResultTableViewCell.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchResultCollectionViewCell"
    
    private let imageBackgroundView = UIView()
    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ConstraintValue.CornerRadius.imageView
        imageView.clipsToBounds = true
        return imageView
    }()
    let likeButton = LikeButton(isActive: false)
    let mallNameLabel = MallNameLabel(text: "월드캠핑카")
    let titleLabel = SearchResultTitleLabel(text: "스타리아 2층 캠핑카dddddddd")
    let lpriceLabel = LpriceLabel(text: "19,000,000")
    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [imageBackgroundView, mallNameLabel, titleLabel, lpriceLabel])
        stackView.axis = .vertical
        stackView.spacing = ConstraintValue.CollectionView.stackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureItem(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(stackView)
        imageBackgroundView.addSubview(imageView)
        imageBackgroundView.addSubview(likeButton)
    }
    
    func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(contentView)
        }
        
        imageBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
            make.horizontalEdges.equalTo(stackView.snp.horizontalEdges)
            make.height.equalTo(contentView.snp.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(imageBackgroundView)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(imageBackgroundView.snp.trailing).offset(ConstraintValue.buttonMargin)
            make.bottom.equalTo(imageBackgroundView.snp.bottom).offset(ConstraintValue.buttonMargin)
            make.size.equalTo(ConstraintValue.likeButtonSize)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(stackView.snp.horizontalEdges).inset(ConstraintValue.lineSpacing)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(mallNameLabel.snp.horizontalEdges)
        }
        
        lpriceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(mallNameLabel.snp.horizontalEdges)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}
