//
//  HomeworkViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

/**
 파일이 많아지면 프로토콜 구조만 알고 있으면 프로젝트 전체의 구조를 알 수 있기 때문에, 뷰모델의 프로토콜은 이런 기반으로 만들어져있어
 */
final class HomeworkViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        // 10.
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        
        // 16.
//        let cellSelected: ControlEvent<Int>
        let cellSelected: ControlEvent<Lotto>
    }
    
    // 1. <MVVM>
//    let list: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])
//    let items = BehaviorRelay(value: ["a", "b", "c"])
    struct Output {
        // 2. 클래스 안에 있어도 되지만 self를 붙이기 귀찮아서 지역상수로 선언
        let list: BehaviorRelay<[Lotto]>
        let items: BehaviorRelay<[String]>
        
        let showAlert: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        // 4.
        let list = BehaviorRelay(value: [Lotto(drwNoDate: "더미데이터 - 테스트", firstAccumamnt: 10)])
        let items = BehaviorRelay(value: ["1", "2", "3"])
        
        
        let showAlert = PublishRelay<Bool>()
        
        /*
        // 9.
//        searchBar.rx.searchButtonClicked
        // 12.
        input.searchTap
//            .withLatestFrom(searchBar.rx.text.orEmpty)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
//                CustomObservable.getLotto(query: text)
                
                // 에러핸들링 (3) 내부에서 catch
                /*
                    .catchAndReturn(Lotto(drwNoDate: "자식이 해결", firstAccumamnt: 0))
                */
                // 새로운 옵저버블을 뱉어줄 수 있어서
                // 새로운 스트림을 만드는데 아무 이벤트를 안주는 스트림을 쓸 수 있음
                /*
                    .catch{ _ in
                        return Observable.never()
                    }  // 사용자에게 문제상황을 보여주고 싶지 않음: 문제발생시 아무 이벤트도 발생하지 않음을 next로 보냄
                */
                
                CustomObservable.getResultLotto(query: text)
                    .debug("로또 옵저버블")
                
            }
        // 에러핸들링 (1) retry
        /*
        // 서치바 구독 해제되었다가 다시 구독을 함
        // 단, 3번이 지나면 구독이 해제되어서 다시 검색 못함
        // 사용자가 잘 입력할 수 있도록 기대해야 함
            .retry(3)  // 3번정도 기회를 줘보자 (무한루프가 돌 수 있어서 보통 횟수에 대한 제한을 주는 편이다
         */
        // 에러핸들링 (2) catch
        /*
            .catchAndReturn(
                Lotto(drwNoDate: "문제있어요", firstAccumamnt: 0)  // 오류발생시 더미(Lotto)라도 보여줌
            )
         */
            .debug("서치바 옵저버블")
        /*
        // 둘은 비슷하지만, 그냥catch는 에러의 상황에 따라서 다른 리턴을 해줄 수 있음
            .catch{ error in
                if error as! JackError == JackError.invalid { }
                
                let a = Lotto(drwNoDate: "문제1", firstAccumamnt: 0)
                return Observable.just(a)  // 다른 옵저버블을 뱉어줄 수 있음
            }
         */
            .subscribe(with: self) { owner, /*lotto*/response in
                print("onNext", response)
                
                /*
                // 13.
//                var data = owner.list.value
                var data = list.value
                data.insert(lotto, at: 0)
                
//                owner.list.accept(data)
                list.accept(data)
                */
                
                switch response {
                    
                case .success(let value):
                    var data = list.value
                    data.insert(value, at: 0)
                    list.accept(data)
                case .failure(let error):
                    print("오류 발생", error)
                    showAlert.accept(true)
                }
                
                
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        */
        
        // 15.
//        tableView.rx.modelSelected(Int.self)  // Observable
        // 18. 왜 셀클릭하면 런타임 이슈?
        /**
         RxCocoa/RxCocoa.swift:153: Fatal error: Failure converting from Optional(SeSACRxThreads.Lotto(drwNoDate: "더미데이터 - 테스트", firstAccumamnt: 10)) to Int
         */
        input.cellSelected
            .map { "셀 \($0)" }
            .bind(with: self) { owner, number in
                
                // 19.
//                var original = owner.items.value
                var original = items.value
                original.insert(number, at: 0)
//                owner.items.accept(original)
                items.accept(original)
            }
            .disposed(by: disposeBag)
        
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLottoWithSingle(query: text)
                // 아예 들어오지 않으니까 필요없음
//                    .catch { _ in
//                        return Single<Result<Lotto, JackError>>.never()
//                    }
                    .debug("로또 옵저버블")
            }
            .debug("서치바 옵저버블")
            .subscribe(with: self) { owner, response in
                print("onNext", response)
                // 원래는 반환값이 Observable<Result<Lotto>>였는데 바뀌었기 때문에, response가 바뀌었을 수 있기 때문에 오류가 날 가능성이 있다. 그러면 스위치문을 사용할 수 없음
                switch response {
                case .success(let value):
                    var data = list.value
                    data.insert(value, at: 0)
                    list.accept(data)
                case .failure(let error):
                    print("오류 발생", error)
                    showAlert.accept(true)
                }
                    
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        
        // 3.
        return Output(list: list, items: items, showAlert: showAlert)
        // 최종 뷰컨에서 보여주고 싶은 내용만 리턴으로 보여줌
    }
}
