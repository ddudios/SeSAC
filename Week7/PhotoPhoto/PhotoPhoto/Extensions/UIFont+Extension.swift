//
//  UIFont+Extension.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

extension UIFont {
    /// for Header
    struct Heading {
        static let bold28 = UIFont.systemFont(ofSize: 28, weight: .bold)
        static let bold24 = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let bold22 = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let bold20 = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let bold18 = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let bold16 = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    /// for Title, Header
    struct Title {
        static let semibold20 = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let semibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
        /// for Title only
        static let semibold14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    /// for 일반적인 글
    struct Body {
        static let regular16 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)
        /// for 짧은 텍스트
        static let regular13 = UIFont.systemFont(ofSize: 13, weight: .regular)
        /// for Caption, 부연설명
        static let regular12 = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    /// for Button, Label, UI, Keyword
    struct Prominent {
        static let medium16 = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let medium14 = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let medium12 = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
        
    /// for Button, Label, UI, Keyword
    struct label {
        static let semibold16 = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
