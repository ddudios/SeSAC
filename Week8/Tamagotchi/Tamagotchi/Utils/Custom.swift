//
//  Custom.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit

struct CustomFont {
    static let headline = UIFont.boldSystemFont(ofSize: 14)
    static let buttonTitle = UIFont.boldSystemFont(ofSize: 15)
    static let shoppingList = UIFont.systemFont(ofSize: 14)
}

struct CustomUI {
    static func designDividerUI(_ view: UIView, opacity: Float = 1) {
        view.backgroundColor = .Tamagotchi.signiture
        view.layer.opacity = opacity
    }
    
    static func designTextFiledUI(_ tf: UITextField, placeholder: String, textAlignment: NSTextAlignment = .center, keyboardType: UIKeyboardType = .default) {
        tf.backgroundColor = .Tamagotchi.background
        tf.borderStyle = .none
        tf.textAlignment = textAlignment
        tf.tintColor = .Tamagotchi.signiture
        tf.keyboardType = keyboardType
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        tf.textColor = .Tamagotchi.signiture
    }
}
