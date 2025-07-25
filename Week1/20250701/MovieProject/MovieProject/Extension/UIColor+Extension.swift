//
//  UIColor+Extension.swift
//  MovieProject
//
//  Created by Suji Jang on 7/21/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let main = UIColor.rgb(red: 223, green: 92, blue: 86)
    static let sub = UIColor.rgb(red: 95, green: 95, blue: 95)
}
