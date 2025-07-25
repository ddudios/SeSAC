//
//  Bundle+Extension.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import Foundation

enum APIKeyHeader: String {
    case naverClientId = "X-Naver-Client-Id"
    case naverClientSecret = "X-Naver-Client-Secret"
}

enum APIKeyType: String {
    case naverClientId = "NaverClientId"
    case naverClientSecret = "NaverClientSecret"
}

extension Bundle {
    static func getAPIKey(for key: APIKeyType) -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("error: Couldn't find file 'Info.plist'.")
        }
        
        guard let value = plistDict.object(forKey: key.rawValue) as? String else {
            fatalError("error: Couldn't find key '\(key.rawValue)' in 'Info.plist'.")
        }
        
        return value
    }
}
