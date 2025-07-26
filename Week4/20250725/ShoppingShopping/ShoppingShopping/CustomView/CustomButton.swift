//
//  CustomButton.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

final class SortButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, isActive: Bool = false) {
        super.init(frame: .zero)
        layer.cornerRadius = ConstraintValue.CornerRadius.button
        clipsToBounds = true
        if isActive {
            let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.Prominent.medium16, NSAttributedString.Key.foregroundColor: UIColor.black])
            setAttributedTitle(attributedTitle, for: .normal)
            backgroundColor = .white
        } else {
            let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.Prominent.medium16, NSAttributedString.Key.foregroundColor: UIColor.white])
            setAttributedTitle(attributedTitle, for: .normal)
            backgroundColor = .clear
            layer.borderWidth = ConstraintValue.borderWidth
            layer.borderColor = UIColor.white.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LikeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(isActive: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = .white
        tintColor = .black
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / ConstraintValue.circleValue
        }
        clipsToBounds = true
        setTitle("", for: .normal)
        isActive ? setImage(UIImage(systemName: "heart.fill"), for: .normal) : setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
