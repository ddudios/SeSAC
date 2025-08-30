//
//  SectionData.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import Foundation

enum TopicId: String, CaseIterable {
    case goldenHour = "golden-hour"
    case business = "business-work"
    case architecture = "architecture-interior"
    
    var sectionTitle: String {
        switch self {
        case .goldenHour:
            return "골든 아워"
        case .business:
            return "비즈니스 및 업무"
        case .architecture:
            return "건축 및 인테리어"
        }
    }
}

struct TopicData {
    let title: String
    let topics: [Topic]
    
    var items: [String] {
        return topics.compactMap { $0.title }
    }
}

struct Topic: Decodable {
    let id: String?
    let createdAt: Date?
    let width: Int
    let height: Int
    let urls: Urls
    let stars: Int
    let user: User
    
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case urls
        case stars = "likes"
        case user
        
        case title
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.createdAt = try? container.decode(Date.self, forKey: .createdAt)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.stars = try container.decode(Int.self, forKey: .stars)
        self.user = try container.decode(User.self, forKey: .user)
        
        self.title = ""
    }
}

struct Urls: Decodable {
    let raw: String
    let small: String
}

struct User: Decodable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let medium: String
}
