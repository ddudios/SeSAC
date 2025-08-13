//
//  PhotoRouter.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/13/25.
//

import Foundation
import Alamofire

// 네트워킹하기 전에 필요한 것들을 한곳에서 관리하기 위함
enum PhotoRouter {
    case one(id: Int)  // 열거형에 매개변수 받기 (사용하지 않아도 됨) (호출부에서 사용되는 이름)
    case list
    
    var baseURL: String {
        return "https://picsum.photos/"
    }
    
    // "https://picsum.photos/id/\(id)/info"
    // "https://picsum.photos/v2/list?page=1&limit=20"
    // endpoint: 최종적으로 요청하는 url
    var endpoint: URL {
        switch self {
        case .one(let jack):  // 매개변수가 하나이고 그 매개변수를 사용하니까 같은 id가 아닌 아무 이름이나 사용해도된다
            URL(string: baseURL + "id/\(jack)/info")!
            // 휴먼 에러 주의 ~!
        case .list:
//            URL(string: baseURL + "v2/list?page=1&limit=20")!
                URL(string: baseURL + "v2/list")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    // AF에서 제공: Parameters
    var parameter: Parameters {
        switch self {
        case .one(let id):
            return ["":""]
        case .list:
            return ["page": "1", "limit": "20"]
        }
    }
    
    // 헤더 있다면 사용
//    var headers: HTTPHeaders {
//        return ["Authorization": "Bearer \()"]
//    }
}
