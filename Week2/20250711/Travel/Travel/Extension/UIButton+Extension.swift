//
//  UIButton+Extension.swift
//  Travel
//
//  Created by Suji Jang on 7/20/25.
//

import UIKit

extension UIButton {
    func divider(_ buttonTitle: String, hidden: Bool = true) {
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        let title = NSAttributedString(string: buttonTitle, attributes: [NSAttributedString.Key.font : CustomFont.subhead, NSAttributedString.Key.foregroundColor: UIColor.white])
        setAttributedTitle(title, for: .normal)
        
        setImage(UIImage(systemName: "calendar"), for: .normal)
        tintColor = .white
        
        isHidden = hidden
    }
}
