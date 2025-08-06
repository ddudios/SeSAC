//
//  Coin.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import Foundation

struct Coin: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    var coinOverview: String {
        return "\(market) | \(korean_name)(\(english_name))"
    }
}
