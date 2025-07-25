//
//  UIColor+Extension.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/22/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let nPayMain = UIColor.rgb(red: 9, green: 171, blue: 129)
    static let nPayBackground = UIColor.rgb(red: 12, green: 20, blue: 29)
    static let nPaySegmentedButton = UIColor.rgb(red: 38, green: 52, blue: 71)
}
