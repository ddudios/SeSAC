//
//  CustomTextField.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/19/25.
//

import UIKit

final class CustomTextField: UITextField  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        borderStyle = .line
        textAlignment = .right
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
