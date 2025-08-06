//
//  SettingTableViewCell.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
  
    let settingImageView = UIImageView()
    let settingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(settingImageView)
        contentView.addSubview(settingLabel)
    }
    
    func configureLayout() {
        settingImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(50)
        }
        
        settingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(settingImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        settingImageView.contentMode = .scaleAspectFill
        settingImageView.backgroundColor = .red
        settingLabel.numberOfLines = 0
        settingLabel.font = .systemFont(ofSize: 13)
    }

}
