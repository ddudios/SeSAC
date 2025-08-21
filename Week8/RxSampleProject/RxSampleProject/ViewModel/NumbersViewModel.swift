//
//  NumbersViewModel.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NumbersViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let inputNumber1: ControlProperty<String>
        let inputNumber2: ControlProperty<String>
        let inputNumber3: ControlProperty<String>
    }
    
    struct Output {
        let text: BehaviorSubject<String>
    }
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        let resultText = BehaviorSubject(value: "")
        
        // 클로저 열린거 뭐지? combineLatest 내부를 열어보면 클로저에서 가공해서 하나의 값으로 return
        Observable.combineLatest(
            input.inputNumber1,
            input.inputNumber2,
            input.inputNumber3,
            resultSelector: { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        })
        .map { $0.description }  // 문자열로 변환
        .bind(with: self, onNext: { owner, text in
            resultText.onNext(text)
        })
        .disposed(by: disposeBag)
        
        return Output(text: resultText)
    }
}
