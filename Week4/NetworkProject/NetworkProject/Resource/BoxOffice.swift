//
//  BoxOffice.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/25/25.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let dailyBoxOfficeList: [MovieInformation]
}

struct MovieInformation: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
