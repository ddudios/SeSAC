//
//  CustomButton.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "xmark"), for: .normal)
        tintColor = .black
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
