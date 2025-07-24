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
}
