//
//  UserDefaultsHelper.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import Foundation

enum UserDefaultsKey: String {
    case like
}

struct UserDefaultsHelper {
    static var like: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.like.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.like.rawValue)
        }
    }
}
