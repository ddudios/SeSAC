//
//  NetworkTableViewCell.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    
    private let photoImageView = UIImageView()
    private let authorLabel = UILabel()
    private let resolutionLabel = UILabel()
    private let idLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with photo: PhotoList) {
        authorLabel.text = "작가: \(photo.author)"
        resolutionLabel.text = "해상도: \(photo.width) x \(photo.height)"
        idLabel.text = "ID: \(photo.id)"
        let thumbnailUrl = URL(string: photo.download_url)!
        photoImageView.kf.setImage(with: thumbnailUrl)
    }
    
    private func setupUI() {
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 8
        photoImageView.backgroundColor = .systemGray5
        contentView.addSubview(photoImageView)
        
        authorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        authorLabel.numberOfLines = 1
        contentView.addSubview(authorLabel)
        
        resolutionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        resolutionLabel.textColor = .systemGray
        contentView.addSubview(resolutionLabel)
        
        idLabel.font = .systemFont(ofSize: 12, weight: .light)
        idLabel.textColor = .systemGray2
        contentView.addSubview(idLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(photoImageView.snp.top).offset(8)
        }
        
        resolutionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(authorLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(authorLabel)
            make.top.equalTo(resolutionLabel.snp.bottom).offset(4)
        }
    }
}
