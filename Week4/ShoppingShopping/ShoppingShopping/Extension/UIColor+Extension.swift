//
//  UIColor+Extension.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor? {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let naverSigniture = UIColor.rgb(red: 9, green: 171, blue: 129)
}

// struct로도 구현할 수 있을 텐데 이 때는 어떤 것을 막아줘야 하는가?
    // 타입프로퍼티로 구현했음에도 불구하고 무수히 많은 인스턴스를 생성할 수 있다
    // 인스턴스 생성을 막고, 타입 호출로 사용하도록 유도한다
struct TESTColoe {
//    static let shared = TESTColoe()
    // 내부 인스턴스 메서드, 프로퍼티가 없으니 불필요하다
    
    private init() { }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor? {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let naverSigniture = UIColor.rgb(red: 9, green: 171, blue: 129)
}

//let testColor = TESTColoe()
//let testColor1 = TESTColoe()
//let testColor2 = TESTColoe()
//let testColor3 = TESTColoe()
//let testColor4 = TESTColoe()
//let testColor5 = TESTColoe()

//MARK: enum으로는 어떻게 구현할 수 있을까?
