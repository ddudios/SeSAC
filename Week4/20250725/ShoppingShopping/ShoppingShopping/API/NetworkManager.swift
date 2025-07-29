//
//  NetworkManager.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/30/25.
//

import Foundation
import Alamofire

class NetworkManager {
    // Singleton Pattern
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest(query: String, sort: String, startPosition: Int, success: @escaping (NaverSearch) -> Void, failure: () -> Void) {
        guard let url = URL(string: NaverShoppingUrl(query: query, sort: sort, start: startPosition).url) else {
            print("error: URL - \(#function)")
            return
        }
        let header: HTTPHeaders = [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
