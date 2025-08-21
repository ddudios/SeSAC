//
//  SimpleValidationViewModel.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    struct Input {
        let username: ControlProperty<String>
        let password: ControlProperty<String>
    }
    
    struct Output {
        let usernameValid: Observable<Bool>
        let passwordValid: Observable<Bool>
        let everythingValid: Observable<Bool>
        let usernameValidText: Observable<String>
        let passwordValidText: Observable<String>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        let usernameValidText = Observable.just("Username has to be at least \(minimalUsernameLength) characters")
        let passwordValidText = Observable.just("Password has to be at least \(minimalPasswordLength) characters")
        
        //.share: share를 하지 않지 않으면 usernameValid가 계속 생성됨 (여러 군데에서 구독할 때, 리소스 아끼려고 사용)
        let usernameValid = input.username
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = input.password
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
 
        // Output에 output을 만들어놓고 return 넣을 거를 내부에 선언해주기
        return Output(usernameValid: usernameValid, passwordValid: passwordValid, everythingValid: everythingValid, usernameValidText: usernameValidText, passwordValidText: passwordValidText)
    }
}
