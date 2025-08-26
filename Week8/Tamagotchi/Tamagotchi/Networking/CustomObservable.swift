//
//  CustomObservable.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkError: Error {
    case error
    case connectedToInternetError
}

// 네트워크 연결 유무 판별
class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

final class CustomObservable {
    private init() { }
    
    static func getLotto(query: String) -> Observable<Lotto> {
        return Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            guard Connectivity.isConnectedToInternet else {
                observer.onError(NetworkError.connectedToInternetError)
                return Disposables.create()
            }
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(_):
                    observer.onError(NetworkError.error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    static func getMovie(date: String) -> Observable<BoxOfficeResult> {
        return Observable.create { observer in
            
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOffice.rawValue)&targetDt=\(date)"
            
            AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(_):
                    observer.onError(NetworkError.error)
                }
            }
            return Disposables.create()
        }
    }
    
    static func getMovieResult(date: String) -> Observable<Result<BoxOfficeResult, NetworkError>> {
        return Observable.create { observer in
            
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOffice.rawValue)&targetDt=\(date)"
            
            guard Connectivity.isConnectedToInternet else {
                observer.onNext(.failure(.connectedToInternetError))
                return Disposables.create()
            }
            
            AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
                switch response.result {
                case .success(let value):
                    /**
                     @frozen public enum Result<Success, Failure> where Failure : Error, Success : ~Copyable {
                         case success(Success)
                         case failure(Failure)
                     */
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
    
    static func getMovieWithSingle(date: String) -> Single<Result<BoxOfficeResult, NetworkError>> {
        return Single.create { observer in
            /**
             public static func create(subscribe: @escaping (@escaping SingleObserver) -> Disposable) -> Single<Element> {
                 let source = Observable<Element>.create { observer in
                     return subscribe { event in
                         switch event {
                         case .success(let element):
                             observer.on(.next(element))
                             observer.on(.completed)
                         case .failure(let error):
                             observer.on(.error(error))
                         }
                     }
                 }
                 
                 return PrimitiveSequence(raw: source)
             }
             */
            
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOffice.rawValue)&targetDt=\(date)"
            
            guard Connectivity.isConnectedToInternet else {
                observer(.success(.failure(.connectedToInternetError)))
                return Disposables.create()
            }
            
            AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
                switch response.result {
                case .success(let value):
                    /**
                     observer: (Result<Result<BoxOfficeResult, NetworkError>, any Error>) -> Void
                     */
                    observer(.success(.success(value)))
                case .failure(_):
                    observer(.success(.failure(.error)))
                }
            }
            return Disposables.create()
        }
    }
}
