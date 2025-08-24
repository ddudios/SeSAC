//
//  SelectTamagotchiCollectionViewCell.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift

final class SelectTamagotchiCollectionViewCell: BaseCollectionViewCell {
    let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "1-6")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var nameLabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        label.layer.borderWidth = 1
        label.text = "따끔따끔 다마고치"
        label.textColor = .Tamagotchi.signiture
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
    }
}
