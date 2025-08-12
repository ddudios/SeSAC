//
//  ReviewObservable.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

class ReviewObservable<T> {  // 제네릭 환경
    
    private var action: (() -> Void)?  // 사용할 수도 있고 안할 수도 있음
    
    var value: T { // 실제 저장해서 사용할 데이터
        didSet {
            print("Observable didSet")
            action?()  // 기능이 있으면 실행
        }
    }
    
    init(_ value: T) {  // 보기 싫은 것들을 줄여가기 -> _
        print("Observable Init")
        self.value = value
    }
    
    // 우회적으로 action클로저에 함수를 넣어주는 형태
    func bind(action: @escaping () -> Void) {  // 매개변수명과 함수명이 같으면 self
        print("Observabe Bind")
        action()  // 어떤 상황에 필요할 지, 필요하지 않은 순간은 언제일 지
        self.action = action
    }
    
    // 즉시실행하지 않는 bind
    func lazyBind(action: @escaping () -> Void) {
        print("Observabe lazyBind")
        // 매개변수 실행하지 않고 담아만 둬서 최초에 실행되지 않음
        self.action = action
    }
}
