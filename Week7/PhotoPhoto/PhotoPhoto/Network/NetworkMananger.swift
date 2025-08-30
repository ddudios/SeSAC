//
//  NetworkMananger.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import Foundation
import Alamofire

final class NetworkMananger {
    static let shared = NetworkMananger()
    private init() { }
    
    func callRequest<T: Decodable>(api: APIRouter, type: T.Type, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString)
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
