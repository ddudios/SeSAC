//
//  Upbit.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

struct Upbit: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    // 연산프로퍼티는 메모리공간을 차지하지 않기 때문에 구조체와 상관없음
    var overview: String {
        "\(korean_name) | \(english_name)"
    }
}
