//
//  UIColor+Extension.swift
//  Travel
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let babyPink = UIColor.rgb(red: 255, green: 212, blue: 211)
    static let babyGreen = UIColor.rgb(red: 214, green: 255, blue: 211)
    static let babyBlue = UIColor.rgb(red: 126, green: 174, blue: 229)
}
