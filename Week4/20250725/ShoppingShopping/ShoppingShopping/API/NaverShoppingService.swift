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
    var query: String
    var sort: String
    var url: String
    
    init(query: String, sort: String) {
        self.query = query
        self.sort = sort
        self.url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=100\(sort)"
    }
    
    /*
    // 함수를 실행하면 네트워크 통신을 시작하고 -> 통신이 끝날 때까지 기다리지 않고 함수를 종료: 아직 success value가 생성되지 않았음으로 무조건 nil을 뱉는다
    // 통신이 끝나서 네트워킹 결과값이 생긴 시점에 그 결과값을 return해주는 방법을 알아야 사용할 수 있는 함수
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
    }
     */
}
