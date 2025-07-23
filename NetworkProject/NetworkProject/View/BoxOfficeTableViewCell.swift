//
//  BoxOfficeTableViewCell.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/24/25.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    static let identifier = "BoxOfficeTableViewCell"
    
    let numberLabel = {
        let label = BoxOfficeCellNumberLabel()
        return label
    }()
    let movieNameLabel = {
        let label = BoxOfficeMovieNameLabel()
        label.text = "엽문4: 더 파이널"
        return label
    }()
    let dateLabel = {
        let label = BoxOfficeDateLabel()
        label.text = "8888-88-88"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.centerY.equalTo(contentView.snp.centerY)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(8)
            make.width.equalTo(50)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing)
            make.width.equalTo(75)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func configureView() {
        
    }
}
