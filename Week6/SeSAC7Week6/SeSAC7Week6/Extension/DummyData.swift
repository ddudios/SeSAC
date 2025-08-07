//
//  DummyData.swift
//  SeSAC7Week6
//
//  Created by Suji Jang on 8/7/25.
//

import Foundation
/*
 TMDB 기준
 trending
 - poster, runtime, genreIDs
 search
 - poster, runtime, title, id
 image
 - path
 */

// Generic을 몰랐다면...
    // 더미데이터라도 많은 struct를 만들어야 한다
struct DummyTrend {
    let id: Int
    let genreIds: [Int]
}

struct DummyImage {
    let path: String
    let id: Int
}

struct DummySearch {
    let path: String
    let des: String
}

struct DummyData<T, U> {  // 'U'ppercased
    let title: T  // 타입파라미터에 들어온 타입을 사용
    let sub: U
}

// 제네릭으로 명세했으면 어디에서 쓸 지 타입을 써야한다
