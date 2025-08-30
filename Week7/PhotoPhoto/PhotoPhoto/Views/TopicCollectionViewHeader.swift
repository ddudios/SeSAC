//
//  TopicCollectionViewHeader.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit
import SnapKit

final class TopicCollectionViewHeader: BaseCollectionReusableView {
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "골든 아워"
        label.textColor = .black
        label.font = .Heading.bold16
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
