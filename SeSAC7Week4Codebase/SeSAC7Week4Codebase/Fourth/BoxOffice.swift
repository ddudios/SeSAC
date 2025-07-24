//
//  BoxOffice.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/24/25.
//

import Foundation

// 구조체 이름은 중요하지 않고 내부 변수명과 키 이름이 일치하는 것이 중요하다
// 서버에서 가져오기 때문에 Decodable(외부에서 받아온거구나 /없으면 내가 만든거구나 구분하는 척도가될 수 있다)
// 큰 애가 Decodable이면 작은애들도 채택해야한다
struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let boxofficeType: String  // 안가져올 데이터라 안만들어도 되는데 일단 헷갈리니까 만들어봄
    let showRange: String
    let dailyBoxOfficeList: [BoxOffice]
}

// depth만 잘 맞춰주면 된다
struct BoxOffice: Decodable {
    let movieNm: String
    let openDt: String
}
