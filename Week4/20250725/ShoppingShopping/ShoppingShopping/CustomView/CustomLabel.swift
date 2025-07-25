//
//  CustomLabel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

final class EmptySearchBarTextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        font = UIFont.Heading.bold18
        textAlignment = .center
        text = "쇼핑하구팡"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
