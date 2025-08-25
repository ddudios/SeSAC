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
}

final class CustomObservable {
    private init() { }
    
    static func getLotto(query: String) -> Observable<Lotto> {
        return Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
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
}
