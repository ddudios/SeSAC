//
//  NaverShoppingService.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import Alamofire

struct NaverSearch: Codable {
    let total: Int
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
}

struct NaverShoppingService {
    static func callRequest(_ query: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=100"
        let header: HTTPHeaders = [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { request in
            switch request.result {
            case .success(let value):
                print(value.total)
                print(value.items.first ?? "")
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
}
