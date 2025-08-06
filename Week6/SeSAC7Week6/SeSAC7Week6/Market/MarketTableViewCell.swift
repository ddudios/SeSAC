//
//  MarketTableViewCell.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

final class MarketTableViewCell: UITableViewCell {
    
    static let identifier = "MarketTableViewCell"

    let nameLabel = UILabel()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketTableViewCell {
    func configureHierarchy() {
        //유의사항. ContentView
        contentView.addSubview(nameLabel)
    }
    
    func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(22)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureView() {
        nameLabel.text = "비트코인"
        nameLabel.textColor = .white
    }
    
    
}

