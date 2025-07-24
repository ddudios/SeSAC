//
//  CustomTextField.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class PickerTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.borderStyle = .roundedRect
        self.tintColor = .lotteryGray
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(borderStyle: UITextField.BorderStyle, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.borderStyle = borderStyle
        self.keyboardType = keyboardType
        tintColor = .black
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
