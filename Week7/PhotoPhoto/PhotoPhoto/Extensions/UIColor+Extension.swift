//
//  UIColor+Extension.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    struct PhotoPhoto {
        private init() { }
        static let signiture = UIColor.rgb(red: 24, green: 111, blue: 242)
        static let gray = UIColor.rgb(red: 140, green: 140, blue: 140)
    }
}
