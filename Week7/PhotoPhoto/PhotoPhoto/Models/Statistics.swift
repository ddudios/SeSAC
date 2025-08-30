//
//  Statistics.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import Foundation

struct Statistic: Decodable {
    let id: String?
    let downloads: Download?
    let views: Views?
}

struct Download: Decodable {
    let total: Int
    let historical: DownloadHistorical
}

struct DownloadHistorical: Decodable {
    let values: [DownloadValue]
}

struct DownloadValue: Decodable {
    let date: String
    let value: Int
}

struct Views: Decodable {
    let total: Int
    let historical: ViewHistorical
}

struct ViewHistorical: Decodable {
    let values: [ViewValue]
}

struct ViewValue: Decodable {
    let date: String
    let value: Int
}
