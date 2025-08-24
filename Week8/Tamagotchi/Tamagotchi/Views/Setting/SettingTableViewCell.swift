//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    let iconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .Tamagotchi.signiture
        imageView.backgroundColor = .Tamagotchi.background
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "내 이름 설정하기"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let subtitleLabel = {
        let label = UILabel()
        label.text = "고래밥"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    private func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
        }
    }
}
