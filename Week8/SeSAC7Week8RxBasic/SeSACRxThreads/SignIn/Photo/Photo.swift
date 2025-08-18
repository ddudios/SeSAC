//
//  Photo.swift
//  SeSACRxThreads
//
//  Created by Jack on 8/18/25.
//

import Foundation

// error 처리 - 1.
/*
struct Photo: Decodable {
    let id: String?
    let weight: Int?
    let height: Int?
    let urls: ImageURL?
    
    // 성공 시에는 모든 값이 오지만 실패했을 때는 값이 안 올 수 있으니까 전부 옵셔널로 변경 (가장 직관적인 해결책)
        // 성공 시에는 errors가 안 올거고
        // 싱패 시에는 id, weight, height, urls가 안 올 테니까
        // 전부 옵셔널 처리
    let errors: [String]?
}

struct ImageURL: Decodable {
    let regular: String
}
*/

// 실패 핸들링 시 모든 응답값을 옵셔널로 만드니까 불필요한 것까지 옵셔널이 돼서, 성공 모델은 성공끼리, 실패 모델은 실패끼리 나눠서 대응

// error 처리 - 2.
// 성공했을 때의 데이터 구조
struct Photo: Decodable {
    let id: String
    let weight: Int?
    let height: Int?
    let urls: ImageURL
}

struct ImageURL: Decodable {
    let regular: String
}

// 실패했을 때의 데이터 구조
struct PhotoError: Decodable {
    let errors: [String]
}
// 장점: 불필요한 요소를 옵셔널로 하지 않아도 됨, 실패에 대한 JSON을 얻을 수 있음
