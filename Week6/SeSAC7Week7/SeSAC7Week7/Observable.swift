//
//  Observable.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/11/25.
//

import Foundation

class Observable {
    
    private var hello: (() -> Void)?  // 프로퍼티에 클로저를 담아서 생성: text 바뀔 때 실행
        // private 가능해짐
    
    // 프로퍼티 생성
        // ViewModel의 inputField 한번 감싸주려고
        // 처음에 들어오는 jack 값은 didSet은 실행되지 않음, 값이 있는 상태에서 변경이 됐을 때 didSet이 실행됨
    var text: String {
        // 프로퍼티가 달라진걸 알게끔 만듦 (신호받음)
        didSet {
            print("text 값이 바뀌었어요", oldValue, text)
            hello?()
        }
    }
    
    init(text: String) {
        self.text = text
        print("text 값을 초기화해서 Observable 인스턴스를 만들었다")
    }
    
    func binde(closure: @escaping () -> Void) {
        // 실행과 동시에 값을 줌
        closure()
        self.hello = closure
    }
}
