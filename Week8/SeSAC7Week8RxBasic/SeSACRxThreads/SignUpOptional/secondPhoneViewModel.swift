//
//  secondPhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class SecondphoneViewModel {
    struct Input {
        let buttonTap: ControlEvent<Void>
        let text: ControlProperty<String>
    }
    
    struct Output {
        // 보통 이럴때 서브젝트 많이 사용
        let text: BehaviorSubject<String> // 레이블에 보여질 글자
    }
    
    let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        let labelText = BehaviorSubject(value: "")
        
        input.buttonTap
            .withLatestFrom(input.text)
            .map { text in
                text.count >= 8 ? "통과": "8자 이상 입력해주세요"
            }
            .bind(with: self, onNext: { owner, value in
                labelText.onNext(value)
            })
            .disposed(by: disposeBag)
        return Output(text: labelText)
    }
}
