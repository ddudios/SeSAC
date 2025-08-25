//
//  BoxOffice.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/25/25.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let dailyBoxOfficeList: [MovieInfo]
}

struct MovieInfo: Decodable {
    let movieNm: String
}
