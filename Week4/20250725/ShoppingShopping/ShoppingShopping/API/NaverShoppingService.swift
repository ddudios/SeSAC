//
//  NaverShoppingService.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import Alamofire

struct NaverSearch: Decodable {
    var total: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
}

struct NaverShoppingService {
    var query: String
    var sort: String
    var url: String
    
    init(query: String, sort: String, start: Int) {
        self.query = query
        self.sort = sort
        self.url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30\(sort)&=\(String(start))"
    }
    
    // 결과를 날려주는 것은 할 수 없음
    /*
    static func callRequest(_ query: String) -> NaverSearch {
        var networkingResult = NaverSearch(total: 0, items: [Item(title: "", image: "", lprice: "", mallName: "")])
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=100"
        let header: HTTPHeaders = [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { request in
            switch request.result {
            case .success(let value):
                networkingResult = value
            case .failure(let error):
                print("fail: \(error)")
                return
            }
        }
        return networkingResult
    }*/
}
