//
//  UserDefaultsHelper.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/22/25.
//

import Foundation

// 상속이 되지 않으면 웬만하면 struct
struct UserDefaultsHelper {
    
    var test = UserDefaults.standard.string(forKey: "name") ?? "손님"
    
    var name: String {
        get {  // 저장된 값을 가져오는 코드
            return UserDefaults.standard.string(forKey: "name") ?? "손님"
        }
        set {  // 데이터를 넣어주는 것이기 때문에 return아님
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    
    var age: Int {
        get {
            return UserDefaults.standard.integer(forKey: "age")
        }
        set {  // age를 통해서 값을 셋팅
            UserDefaults.standard.set(newValue, forKey: "age")  // newValue: 애플이 만든 매개변수
        }
    }
}
