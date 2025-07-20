//
//  UIButton+Extension.swift
//  Travel
//
//  Created by Suji Jang on 7/20/25.
//

import UIKit

extension UIButton {
    func divider(hidden: Bool = false) {
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        let title = NSAttributedString(string: " Sunday, July 20, 2025", attributes: [NSAttributedString.Key.font : CustomFont.subhead, NSAttributedString.Key.foregroundColor: UIColor.white])
        setAttributedTitle(title, for: .normal)
        
        setImage(UIImage(systemName: "calendar"), for: .normal)
        tintColor = .white
        
        isHidden = hidden
    }
}
