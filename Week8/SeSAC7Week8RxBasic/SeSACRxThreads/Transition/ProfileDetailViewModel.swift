//
//  ProfileDetailViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/27/25.
//

import Foundation
import RxSwift
import RxCocoa

class Sample1 {
    var name: String?
    
    init(name: String? = nil) {
        self.name = name
    }
}

class Sample {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
}

final class ProfileDetailViewModel: BaseViewModel {
    
//    private var text: String?  // MVVM요소를 깨지게할 수는 있지만 구조를 지키는 것보다 동작이 되는게 우선순위가 높다고 생각한다면 지금처럼 VM로 받아서 넘겨주고 transform에서 써도 된다
    // private이 아니니까 외부에서 건들일 수 있음
    
    private let text: String  // 클래스 특성상 인스턴스만들어지기 위해서는 내부 프로퍼티들이 모두 초기화되어 있어야함 -> 초기값/옵셔널/이니셜라이저
    // 이전 화면에서 받아와서 생성되고 -> 변경될 일 없기 때문에 let
    // 외부에서 부를 수도, 이니셜라이저 생성될때 받아온 값으로 만들어질 수 있음, 항상 이니셜라이저가 먼저 실행되고 text가 생성되기 때문에 문제없음
    
    init(text: String) {
        self.text = text
    }
    
    struct Input {
        
    }
    
    struct Output {
        let navTitle: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let title = Observable.just("Jack \(Int.random(in: 1...10)) \(text/* ?? "없음"*/)")
        
        return Output(navTitle: title)
    }
}
