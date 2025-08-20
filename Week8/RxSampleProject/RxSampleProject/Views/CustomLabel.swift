//
//  CustomLabel.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/20/25.
//

import UIKit

final class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        self.text = text
        textAlignment = .left
        textColor = color
        font = .systemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
