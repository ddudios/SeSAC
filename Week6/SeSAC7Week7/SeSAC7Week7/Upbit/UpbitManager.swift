//
//  UpbitManager.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation
import Alamofire

// 역할/범주 나누기
    // 어떤게 좋은지 깨달으려면 만들어 가면서 장단점 익히기
final class UpbitManager {
    static let shared = UpbitManager()
    
    private init() { }
    
    func callRequest(completionHandler: @escaping ([Upbit], String) -> Void) {
        print(#function)
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url).responseDecodable(of: [Upbit].self) { response in
            switch response.result {
            case .success(let value):
                let random = value.randomElement()?.korean_name ?? ""
                completionHandler(value, random)
            case .failure(let error):
                print(error)
            }
        }
    }
}
