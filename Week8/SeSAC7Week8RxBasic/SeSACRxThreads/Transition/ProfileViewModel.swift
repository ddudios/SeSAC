//
//  ProfileViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/27/25.
//

import Foundation
import RxSwift  // 온전한 Rx
import RxCocoa  // UIKit wrapping. controlEvent = UIKit  // UIKit을 ViewModel에서 써도 되나? 또는 빠르게 만들기 위해서 사용 가능하다

/**
 final, protocol
 - 코드 규모 크면, 작아야 파일 단위가 만개
 - 그럴 때, protocol 검색: 가이드, 이걸 어디서 쓰고 있지? 그 파일은 이 기능을 하고 있구나
 - 코드의 의도를 주석 대신
 - 다른 사람이 이 프로젝트를 본다고 생각
 - 골격을 잡아 놓는 게 코드를 이해하는 데 도움됨
 - 이 규약을 위배해서 코드를 짜지는 않을 테니까
 
 BaseViewModel
 - 무조건 이 구조인 건 인지했음
 - 프로토콜에서 온 것들은 은닉화를 시키기 어려움 private
 - 어디서든 사용할 수 있어야 하니까
 - 프로토콜 추상화를 통해서 잘 읽히게 하려면, private은 버려야하고, 은닉화를 챙기려면 프로토콜을 챙겨가기는 어렵다
 */
final class ProfileViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
//        let buttonTap: ControlEvent<Void>
        // 어떤 동작을 할 수 있을지 인지
        let buttonTap: Observable<Void>  // RxCocoa 안쓰기위함
    }
    
    struct Output {
//        let detail: BehaviorRelay<String>  // Observable을 사용하면 accept를 사용할 수 없음
//        let detail: PublishRelay<String>
        // 이벤트를 받을 수 있는 객체로 Observable -> Subject
        // 오류 발생X: subject -> relay(next만, MainThread보장X -> UI핸들링시 .observe(on: ConcurrentDispatchQueueScheduler(qos: .default) 하면 .observe(on: MainScheduler.instance)해줘야함)
        
        let detail: Driver<String>
        
        // 이벤트를 받아오지는 않고 전달만 하기 때문에 Observable 사용
        let placeholder: Observable<String>
        let buttonTitle: Observable<String>
    }
    
    func transform(input: Input) -> Output {
//        let detail = BehaviorRelay(value: "Behavior 바로 바인드된 초기값")
        // Output의 detail에 접근하기 쉽지 않아서 지역상수로 선언
        // 초기값을 가지고 있기 때문에 화면을 열자마자 Detail 화면으로 전환이 일어남
        // 그러니까 초기값이 방출되지 않는, next이벤트 있을 때 실행되도록 Publish로
        let detail = PublishRelay<String>()
        
        input.buttonTap
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))  // 이 코드 이후로 background에서 동작 -> 화면전환을 해줄 수 없음
        // observe(on)으로 한번 바꿔주면 계속 유지됨
            .bind(with: self) { owner, _ in
                print("통신이 일어난다면", Thread.isMainThread)
                // 통신이 일어난다면 false
                // [error]Thread 7: "Call must be made on main thread"
                detail.accept("고래밥")
            }
            .disposed(by: disposeBag)
        
        // .withUnretained(self)하면 매개변수가 늘어나니까 타입이 일치하지 않아서 catch다음에 사용하기는 어렵다
//        input.buttonTap
//            .withUnretained(self)
//            .bind(with: self) { <#AnyObject#>, <#(ProfileViewModel, Void)#> in
//                <#code#>
//            }
        
        // 어디에 .distinctUntilChanged()를 붙이느냐에 따라서 달라질 수 있어서 같은 오퍼레이터라고 하더라도 스트림 순서도 중요: 각각 타입을 찍어보면서 해야함
//        input.buttonTap
//            .withLatestFrom(Observable.just("dfd"))
//            .distinctUntilChanged()
//            .debounce(<#T##dueTime: RxTimeInterval##RxTimeInterval#>, scheduler: <#T##any SchedulerType#>)
//            .distinctUntilChanged()
        
        
//        return Output(detail: detail)
        return Output(
            detail: detail.asDriver(onErrorJustReturn: ""),
            placeholder: Observable.just("닉네임을 입력해주세요"),
            buttonTitle: Observable.just("다음")  // 모든 글자까지 만들어야할 필요가있을까? 극단적 MVVM으로 만드려고 하는 경우도 있음
        )
        // Observable.just는 유한한 이벤트 방출이기 때문에 메모리에 남아있지 않음 (리소스 정리됨 isDisposed)
    }
}
