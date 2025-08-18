//
//  PhotoError.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/19/25.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case serverError = 500
    case unknown = 503
    
    var userResponse: String {
        switch self {
        case .badRequest:  // 사용자에게 보여줘야 하기 때문에 더 직관적으로 적어줘야 한다
            "Bad Request 입니다."
        case .unauthorized:
            "Unauthorized 입니다."
        case .forbidden:
            "Forbidden 입니다."
        case .notFound:
            "notFound 입니다."
        case .serverError:
            "serverError 입니다."
        case .unknown:
            "알 수 없는 에러입니다."
        }
    }
}
