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
        let text: BehaviorSubject<String>
    }
    
    // 뷰모델 별개의 disposeBag
    private let disposeBag = DisposeBag()
    
    init() {}
    
    func transform(input: Input) -> Output {
        let text = BehaviorSubject(value: "")
            // 버튼 클릭 시 -> subject
        input.buttonTap
                .bind(with: self) { owner, _ in
                    text.onNext("칙촉 \(Int.random(in: 1...100))")
                }
                .disposed(by: disposeBag)
        
        return Output(text: text)
    }
}
