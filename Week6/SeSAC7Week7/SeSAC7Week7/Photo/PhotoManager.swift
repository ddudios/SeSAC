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
                //MARK: - 12:26
            case .success(let value):  // Photo.self에 따라서 네트워크 통신이 정해지고 value타입은 Photo.self타입으로 정해짐 T.self가 정해져야 success의 벨류타입이 정해져야 (T)를 받아옴
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
}
