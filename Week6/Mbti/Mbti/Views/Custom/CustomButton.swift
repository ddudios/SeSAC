//
//  CustomButton.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import UIKit

final class RoundedRectButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        setAttributedTitle(attributedTitle, for: .normal)
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

final class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        backgroundColor = .clear
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        setAttributedTitle(attributedTitle, for: .normal)
        setTitleColor(.systemGray, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}
