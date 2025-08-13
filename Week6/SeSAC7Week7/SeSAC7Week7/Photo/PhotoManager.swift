//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

/**
 1. AF.request 메서드 하나를 활용할 수 없나? => meta type
 - AF의 request 너무 많아지니까 하나로 합치고 싶음 ->  요청 로직을 한곳에서 관리: router pattern
 - 디코딩으로 담아오는 struct를 generic으로 만들기: meta type에 대한 이해 필요
 2. 요청 로직을 한 곳에서 관리할 수 없나?
 */

final class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }
    
//    func getOnePhoto(id: Int, success: @escaping (Photo) -> Void) {
//        let url = "https://picsum.photos/id/\(id)/info"
//        
//        AF.request(url).responseDecodable(of: Photo.self) { response in
//            switch response.result {
//            case .success(let value):
//                success(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    func getOnePhoto(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        AF.request(api.endpoint, method: api.method ).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                // success의 value는 성공을 했을 때의 value
                // 이 value가 정해지는 방식은, .responseDecodable(of: T.self)의 T에 들어가는 내용이 무엇인지에 따라 달라진다
                // let value의 value내용이 Photo 타입으로 지정이 되고, success로 Photo를 넘겨줬을 때, @escaping에서 (Photo)로 받을 수 있는 이유는 사실상 .responseDecodable(of: Photo.self)에 채택이 되어있는 Photo.self의 내용에 따라 정해진다
                // 그래서 만약에 .responseDecodable(of: PhotoList.self)라고 했으면, 네트워크 통신은 PhotoList.self를 통해서 정해지기 때문에 value가 가지고 있는 타입은 PhotoList로 바뀌는 것을 확인할 수 있다
                // @escaping (Photo)으로 지정한 타입때문에 let value가 정해지는 것이 아니라 .responseDecodable(of: Photo.self)에 결정을 했던 타입때문에 success구문에서 무슨 타입인지 let value가 지정이 된다
                // 그래서 극단적으로 success구문의 photo와 @escaping (Photo)는 전혀 상관이 없다
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhotoList(api: PhotoRouter, success: @escaping ([PhotoList]) -> Void) {
//        let url = "https://picsum.photos/v2/list?page=1&limit=20"
        AF.request(api.endpoint, method: api.method).responseDecodable(of: [PhotoList].self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 타입파라미터에는 무슨 타입이든 들어갈 수 있음
    func callRequest<T: Decodable>(api: PhotoRouter, type: T.Type, success: @escaping (T) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   // AF가 갖고있는 parameters매개변수는 쿼리스트링 자리가 될 수도 있고, post에 HTTP Body 영역이 될 수도 있음
                   encoding: URLEncoding(destination: .queryString)
                   // dictionary를 어디에 붙일지
                   //MARK: - 2:36
        ).responseDecodable(of: T.self) { response in
            // T.self에는 디코더블을 채택하고 있는 것만 들어갈 수 있어야 한다 (외부로부터 들어온 데이터를 우리의 스트럭트로 바꿔주기 위한 것이 디코더블)
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
        //MARK: - 2:23
        // (T) 매개변수를 사용하는 것처럼 보여서 오류가 나지 않지만,
        // T.self가 결정돼야
        
    }
    /**
     .responseDecodable(of: T.self)의 T가 뭔지에 따라서 case .success(let value):
     success(value)의 value가 정해지고, 이 value를 전달해주는 친구가 @escaping (T)의 T로 전달이 돼서
     순서상으로 .responseDecodable(of: T.self)의 T.self가 정해져야 case .success(let value)의 value의 타입이 정해지고 .success(let value)의 value의 타입을 @escaping (T)의 T에 알맞게 전달하는 거라서
     역으로 @escaping (T)의 T의 타입이 정해졌다고해서 .responseDecodable(of: T.self)의 T로 들어오는 구조는 아님
     그래서 .responseDecodable(of: T.self)의 T가 어떤 타입인지 알려주는 매개변수가 필요해진다
     매개변수의 success: @escaping (T) -> Void)의 T는 .responseDecodable(of: T.self)의 T가 정해져야 받아올 수 있는 거라서 success: @escaping (T) -> Void)의 T는 뭐가 됐던 상관없다
     따라서 T의 타입을 매개변수로 받을 수 있도록 만듦: T.Type
     */
}
