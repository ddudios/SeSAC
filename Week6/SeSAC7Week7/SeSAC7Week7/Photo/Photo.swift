//
//  Photo.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

struct PhotoList: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
