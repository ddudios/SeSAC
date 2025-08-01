//
//  NextCollectionViewCell.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/1/25.
//

import UIKit
import SnapKit

class NextCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    static let identifier = "NextCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        backgroundColor = .red
        imageView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
