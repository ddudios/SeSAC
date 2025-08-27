//
//  BookTableViewCell.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/25/25.
//

import UIKit
import SnapKit  // 레이아웃을 잡기 위해서 오픈소스 Import
// 어떤 파일에서 어떤 코드가 들어갈 지가 대략적으로 나와야하기 때문에 import도 코드스타일만큼 중요

//class BookTableViewCell: UITableViewCell {
class BookTableViewCell: BaseTableViewCell {
    static let id = "BookTableViewCell"
        
        let thumbnailImageView = UIImageView()
        let titleLabel = UILabel()
        let subTitleLabel = UILabel()
        let overviewLabel = UILabel()
        /*
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            configureHierarchy()
            configureLayout()
            configureView()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }*/
        
//        func configureHierarchy() {
    override func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(overviewLabel)
    }
        
//        func configureLayout() {
    override func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(18)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            make.top.equalTo(subTitleLabel.snp.bottom)
        }
        
    }
        
//        func configureView() {
    override func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 13)
    }
}
