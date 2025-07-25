//
//  UIColor+Extension.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor? {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let lotteryYellow = UIColor.rgb(red: 251, green: 203, blue: 6)
    static let lotteryBlue = UIColor.rgb(red: 103, green: 199, blue: 243)
    static let lotteryRed = UIColor.rgb(red: 255, green: 112, blue: 115)
    static let lotteryGray = UIColor.rgb(red: 169, green: 169, blue: 169)
}
