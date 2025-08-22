//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

// 뷰컨에서 뭐가 인풋/아웃풋인지 명확하지 않아서 수정

class PhoneViewModel {
    struct Input {
        let buttonTap: ControlEvent<Void>  // nextButton.rx.tap
    }
    
    struct Output {
//        let text: BehaviorSubject<String>  // 초기값 가질 수 있음
        let text: PublishSubject<String>
        let placeholder: BehaviorSubject<String>
        let next: BehaviorSubject<String>
            // next이벤트만 받을 수 있는, 에러 안날것 같으면 Relay
    }
    
    // 뷰모델 별개의 disposeBag
    private let disposeBag = DisposeBag()
    
    init() {}
    
    func transform(input: Input) -> Output {
//        let text = BehaviorSubject(value: "")  // BehaviorSubject 가지고 있는 마지막 값 방출 (현재 불필요한 값 방출중)
        let text = PublishSubject<String>()  // 버튼 클릭 이후부터 이벤트 받을 수 있음
        let next = BehaviorSubject(value: "다음")  // 달라지지 않을 내용을 굳이 이렇게 해야하나? 안해도됨..ㅎ (이벤트 전달은 없지만 초기값주기 위해 사용)
        
            // 버튼 클릭 시 -> subject
        input.buttonTap
                .bind(with: self) { owner, _ in
                    text.onNext("칙촉 \(Int.random(in: 1...100))")
                }
                .disposed(by: disposeBag)
        
        return Output(text: text, placeholder: BehaviorSubject(value: "연락처를 입력해주세요"), next: next)
    }
}
