//
//  ConstraintsValue.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import Foundation

struct ConstraintValue {
    static let searchBarEdge = 0
    static let edge = 4
    static let lineSpacing = 16
    
    static let borderWidth: CGFloat = 1
    static let circleValue: CGFloat = 2
    
    static let buttonMargin = -12
    static let likeButtonSize = 30
    
    struct CornerRadius {
        static let button: CGFloat = 8
        static let imageView: CGFloat = 20
    }
    
    struct CollectionView {
        static let inset: CGFloat = 8
        static let lineSpacing: CGFloat = 8
        static let itemSpacing: CGFloat = 16
        
        static let sideSpacingQuantity: CGFloat = 2
        static let itemSpacingQuantity: CGFloat = 1
        static let itemQuantity: CGFloat = 2
        static let height: CGFloat = 275
        
        static let stackViewSpacing: CGFloat = 4
    }
}
