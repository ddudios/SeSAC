//
//  NetworkManager.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/30/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    // Singleton Pattern
    static let shared = NetworkManager()
    private init() { }
    
//    func getNaverSearch(query: String, sort: String, startPosition: Int, success: @escaping (NaverSearch) -> Void, failure: () -> Void) {
//        guard let url = URL(string: NaverShoppingUrl(query: query, sort: sort, start: startPosition).url) else {
//            print("error: URL - \(#function)")
//            return
//        }
//        let header: HTTPHeaders = [
//            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
//            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
//        ]
//        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { response in
//            switch response.result {
//            case .success(let value):
//                success(value)
//            case .failure(let error):
//                print("error: \(error)")
//            }
//        }
//    }
    
    // Router Pattern
    func callRequest<T: Decodable>(api: NaverRouter, decodedType: T.Type, success: @escaping (T) -> Void, failure: () -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameters, encoding: URLEncoding(destination: .queryString), headers: api.headers)
            .responseDecodable(of: T.self) { response in
                print(#function, api.endpoint, api.method, api.headers)
            switch response.result {
            case .success(let value):
                success(value)
                print(value)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
