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
    case level
    case rice
    case water
    case emptyString = "empty"
    case emptyNickname = "대장"
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
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? UserDefaultsKey.emptyNickname.rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nickname.rawValue)
        }
    }
    
    var level: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.level.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.level.rawValue)
        }
    }
    
    var rice: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.rice.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.rice.rawValue)
        }
    }
    
    var water: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.water.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.water.rawValue)
        }
    }
}
