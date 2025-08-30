//
//  Search.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import Foundation

struct Search: Decodable {
    var results: [SearchResult]
}

struct SearchResult: Decodable {
    let id: String?
    let created_at: String?
    let width: Int?
    let height: Int?
    let urls: SearchUrl?
    let likes: Int?
    let user: SearchUser?
}

struct SearchUrl: Decodable {
    let raw: String
    let small: String
}

struct SearchUser: Decodable {
    let name: String
    let profile_image: SearchProfileImage
}

struct SearchProfileImage: Decodable {
    let medium: String
}

struct LoadMoreRequest {
    let color: String
    let startPosition: Int
}
