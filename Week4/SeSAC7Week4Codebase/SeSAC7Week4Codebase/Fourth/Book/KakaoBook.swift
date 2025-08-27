//
//  KakaoBook.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/28/25.
//

import Foundation

struct KaKaoBookInfo: Decodable {
    let documents: [BookDetail]
    let meta: MetaInfo
}

struct BookDetail: Decodable {
    let price: Int  // 책가격
    let title: String  // 책제목
    let thumbnail: String  // 책이미지
    let contents: String  // 줄거리
    let url: String  // 구매링크
}

struct MetaInfo: Decodable {
    let is_end: Bool
    let total_count: Int
    let pageable_count: Int
}
