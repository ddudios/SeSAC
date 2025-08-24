//
//  AuthManager.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import Foundation
import RxSwift

final class AuthManager {
    static let shared = AuthManager()
    private init() { }
    
    let isLoggedIn = BehaviorSubject(value: false)
    let loginSuccessed = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    func login(skin: String) {
        isLoggedIn.onNext(true)
        loginSuccessed.onNext(())
    }
    
    func logout() {
        isLoggedIn.onNext(false)
    }
}
