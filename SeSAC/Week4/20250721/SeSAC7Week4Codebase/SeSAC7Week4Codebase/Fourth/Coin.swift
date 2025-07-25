//
//  Coin.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/24/25.
//

import Foundation

// Decodable: 외부에서 들어온 데이터를 담아주는 struct라고 명세해주는 것
struct Coin: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    // 연산 프로퍼티: 통로로서의 역할, 직접 저장하지 않음
    var coinOverview: String {
        return "\(market) | \(korean_name)(\(english_name))"
    }
}
