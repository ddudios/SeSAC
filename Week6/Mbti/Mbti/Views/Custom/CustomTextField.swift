//
//  CustomTextField.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .roundedRect
        layer.borderColor = UIColor.systemGray.cgColor
        textAlignment = .left
        textColor = .black
        tintColor = .black
        self.placeholder = placeholder
    }
}
