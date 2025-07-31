//
//  Photo.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/31/25.
//

import Foundation

struct Photo: Decodable {
    let photoInfo: [PhotoInfo]
}

struct PhotoInfo: Decodable {
    let id: String
    let author: String
    let download_url: String
}
