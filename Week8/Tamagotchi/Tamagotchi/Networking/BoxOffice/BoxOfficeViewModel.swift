//
//  BoxOfficeViewModel.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/27/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: BaseViewModelProtocol {
    let disposeBag = DisposeBag()
    
    struct Input {
        let returnSearch: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let list: BehaviorRelay<[MovieInfo]>
        let alertMessage: PublishRelay<String>
        let toastMessage: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        let list: BehaviorRelay<[MovieInfo]> = BehaviorRelay(value: [])
        /**
         왜 Relay를 썼지?
         - 실패할리 없으니까
         왜 실패할 수 없지?
         - Behavior로 기본값을 줬으니까
         */
        let alertMessage = PublishRelay<String>()
        let toastMessage = PublishRelay<String>()
        
        input.returnSearch
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
//                CustomObservable.getMovieResult(date: text)
                CustomObservable.getMovieWithSingle(date: text)
                    .debug("무비 옵저버블")
            }
            .debug("서치바 옵저버블")
            .subscribe(with: self) { owner, response in
                print("onNext 박스오피스")
                switch response {
                case .success(let boxOfficeResult):
                    let data = boxOfficeResult.boxOfficeResult.dailyBoxOfficeList
                    var listValue = list.value
                    listValue.append(contentsOf: data)
                    list.accept(listValue)
                case .failure(let networkError):
                    switch networkError {
                    case .error:
                        toastMessage.accept("네트워크 통신 실패: yyyyMMdd")
                    case .connectedToInternetError:
                        alertMessage.accept("와이파이 연결을 확인하세요.")
                    }
                }
            } onError: { owner, error in
                print("onError 박스오피스")
            } onCompleted: { owner in
                print("onCompleted 박스오피스")
            } onDisposed: { owner in
                print("onDisposed 박스오피스")
            }
            .disposed(by: disposeBag)
        
        return Output(list: list, alertMessage: alertMessage, toastMessage: toastMessage)
    }
}
