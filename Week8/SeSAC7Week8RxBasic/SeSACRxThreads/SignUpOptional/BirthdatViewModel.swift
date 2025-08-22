//
//  BirthdatViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa  // 여기서 UIKit을 import하고 있다
    // viewModel에서 UIKit을 사용하면 안된다면 RxCocoa를 사용하면 안됨
    // Driver, ControlProperty, Relay 사용하면 안됨
    // 당장은 있는게 편한데 없게는 어떻게 쓸까?
import UIKit.UIImageView  // 이렇게 하더라도 UIKit 전부 가져옴
    // 보통 중복되더라도 상단에 써줘야 어떤 코드인지 알기 쉽기 때문에 명세

final class BirthdatViewModel {
    struct Input {
//        let datePicker: ControlProperty<Date>  // 버튼 클릭 자체를 넘기고 있어서 좀 큰 것을 넘김 (이전에는 ()를 넘김)
//        let datePicker: BehaviorSubject<Date>  // RxCocoa를 사용하지 않는 형태
    }
    
    let date: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    struct Output {
        // 초기값을 가지고 가는 형태로 구성
//        let year: BehaviorSubject<String>
        let year: BehaviorRelay<String>  // 오류발생하지 않을 테니까!
        let month: BehaviorSubject<String>
//        let day: BehaviorSubject<String>
//        let day: SharedSequence<DriverSharingStrategy, String>
        let day: Driver<String>
    }
    
    let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
//        let year = BehaviorSubject(value: "2025")
        let year = BehaviorRelay(value: "2025")
        let month = BehaviorSubject(value: "8")
        let day = BehaviorSubject(value: "22")
        
        /**
         transform을 통해서 datePicker의 날짜가 들어오면 -> 아래의 내부에서 연산을 정의하고 -> 이벤트를 전달 받으면 그 이벤트를 그대로 아웃풋에 방출
         */
//        input.datePicker
        date
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
//                year.onNext("\(component.year!)")
                year.accept("\(component.year!)")
                month.onNext(String(component.month!))
                day.onNext(String(component.day!))
            }
            .disposed(by: disposeBag)
        
//        let result = day
//            .asDriver(onErrorJustReturn: "00일")
        
        return Output(year: year, month: month, day: /*result*/day
            .asDriver(onErrorJustReturn: "00일"))
    }
}
