//
//  UIFont+Extension.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

extension UIFont {
    /// for Header
    static let heading1 = UIFont.systemFont(ofSize: 28, weight: .bold)
    static let heading2 = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let heading3 = UIFont.systemFont(ofSize: 22, weight: .bold)
    static let heading4 = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let heading5 = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let heading6 = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    /// for Title, Header
    static let title1 = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let title2 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let title3 = UIFont.systemFont(ofSize: 15, weight: .semibold)
    
    /// for Title
    static let title4 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    /// for 일반적인 글
    static let body1 = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let body2 = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    /// for Button, Label, UI, Keyword
    static let body1Prominent = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let body2Prominent = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let body4Prominent = UIFont.systemFont(ofSize: 12, weight: .medium)
    
    /// for 짧은 텍스트
    static let body3 = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    /// for Caption, 부연설명
    static let body4 = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    /// for Button, Label, UI, Keyword
    static let label1 = UIFont.systemFont(ofSize: 16, weight: .semibold)
}
