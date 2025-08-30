//
//  CustomObservable.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/31/25.
//

import Foundation
import RxSwift
import Alamofire

enum NetworkError: Error {
    case noInternet
    case error
}

// 네트워크 연결 유무 판별
final class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

final class CustomObservable {
    private init() { }
    
    // Router Pattern + Generic + Rx
    static func callRequest<T: Decodable>(api: NaverRouter) -> Observable<Result<T, NetworkError>> {
        return Observable<Result<T, NetworkError>>.create { observer in
            
            // 네트워크 연결 체크
            guard Connectivity.isConnectedToInternet else {
                observer.onNext(.failure(.noInternet))
                observer.onCompleted()
                return Disposables.create()
            }
            
            AF.request(
                api.endpoint,
                method: api.method,
                parameters: api.parameters,
                encoding: URLEncoding(destination: .queryString),
                headers: api.headers
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value))
                    observer.onCompleted()
                    
                case .failure(_):
                    observer.onNext(.failure(.error))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
