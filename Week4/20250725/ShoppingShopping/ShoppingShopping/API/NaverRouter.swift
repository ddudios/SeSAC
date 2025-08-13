//
//  PhotoRouter.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/13/25.
//

import Foundation
import Alamofire

enum NaverRouter {
    
    case search(query: String, start: Int, display: Int, sort: String)
    case recomend
    
    var baseUrl: String {
        return "https://openapi.naver.com/v1/search/shop.json?"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseUrl)!
        case .recomend:
            return URL(string: baseUrl + "query=키티&display=30&sort=sim&=1")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
            ]
    }
    
    var parameters: Parameters {
        switch self {
            
        case let .search(query, start, display, sort):
            return [
                "query": query,
                "start": start,
                "display": display,
                "sort": sort
            ]
        case .recomend:
            return ["": ""]
        }
    }
}
