//
//  Color+Extension.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    struct Tamagotchi {
        private init() { }
        static let background = UIColor.rgb(red: 246, green: 252, blue: 252)
        static let signiture = UIColor.rgb(red: 74, green: 99, blue: 112)
    }
}
