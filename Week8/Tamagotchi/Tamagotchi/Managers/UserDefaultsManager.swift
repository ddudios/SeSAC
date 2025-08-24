//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import Foundation

enum UserDefaultsKey: String {
    case skin
    case nickname
    case emptyString = "대장"
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    var skin: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.skin.rawValue) ?? UserDefaultsKey.emptyString.rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.skin.rawValue)
        }
    }
    
    var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? UserDefaultsKey.emptyString.rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nickname.rawValue)
        }
    }
}
