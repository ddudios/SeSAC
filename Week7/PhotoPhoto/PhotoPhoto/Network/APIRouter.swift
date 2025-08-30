//
//  APIRouter.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import Foundation
import Alamofire

enum APIRouter {
    case topic(topicId: String)
    case statistics(imageId: String)
    case search(keyword: String, page: String, order_by: String, color: String)
    
    var baseUrl: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case let .topic(topicId):
            return URL(string: baseUrl + "topics/\(topicId)/photos?page=1&client_id=\(APIKey.UnsplashAccessKey.rawValue)")!
        case .statistics(imageId: let imageId):
            return URL(string: baseUrl + "photos/\(imageId)/statistics?")!
        case .search:
            return URL(string: baseUrl + "search/photos?")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .topic:
            return ["": ""]
        case .statistics:
            return [
                "page": "1",
                "client_id": APIKey.UnsplashAccessKey.rawValue
            ]
        case let .search(keyword, page, order_by, color):
            return [
                "query": keyword,
                "page": page,
                "per_page": "20",
                "order_by": order_by,
                "color": color,
                "client_id": APIKey.UnsplashAccessKey.rawValue
            ]
        }
    }
}
