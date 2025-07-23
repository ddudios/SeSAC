//
//  CustomView.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class DividerLine: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .opaqueSeparator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
