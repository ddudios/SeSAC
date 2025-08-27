//
//  Book.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/25/25.
//

import Foundation

// Decodable: 디코딩 + 외부에서 가져온 데이터 명시
struct BookInfo: Decodable {
    let items: [BookData]
}

// 댑쓰대로 들어가서 키의 name으로 찾고 유실되는 4개는 담아지는 과정에서 버림
struct BookData: Decodable {
    let title: String
    let link: String
    let author: String
    let pubdate: String
    let description: String
}
