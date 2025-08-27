//
//  LottoViewModel.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: BaseViewModelProtocol {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let resultButtonTap: ControlEvent<Void>
        let text: ControlProperty<String>
    }
    
    struct Output {
        let resultText: BehaviorRelay<String>
        let showAlert: PublishRelay<Error>
        let showToast: PublishRelay<Error>
    }
    
    func transform(input: Input) -> Output {
        let resultText = BehaviorRelay<String>(value: "추첨 결과")
        let showAlert = PublishRelay<Error>()
        let showToast = PublishRelay<Error>()
        // 그냥 한번만 신호를 보내주면 될 것 같은데 왜 Observable + Observer를 써야하나?
            // 한 번 false 방출하면 Observable은 끝남
        
        input.resultButtonTap
            .withLatestFrom(input.text)
            .map {
                CustomObservable.getLotto(query: $0)
                // 부모 스트림이 끊기지 않게 에러 핸들링
//                    .retry()  // 무한 트라이 가능
                
                // 같은 타입만 리턴
//                    .catchAndReturn(Lotto(drwtNo1: 0, drwtNo2: 0, drwtNo3: 0, drwtNo4: 0, drwtNo5: 0, drwtNo6: 0, bnusNo: 0))
                
                // 에러 상황에 따른 리턴 가능
                    // 새로운 옵저버블을 뱉어줄 수 있음
                    // .never(): 아무 이벤트도 발생하지 않음
//                    .catch { error in
//                        guard let networkError = error as? NetworkError else { return Observable.never() }
//                        
//                        switch networkError {
//                        case .connectedToInternetError:
//                            showAlert.accept(error)
//                        default:
//                            showToast.accept(error)
//                        }
//                        return Observable.never()
//                    }
                    .debug("Observable<Observable<Int>>")
            }
            .debug("buttonTap")
            .subscribe(with: self) { owner, observable in
                print("LottoObservable onNext", observable)
                observable
                    .bind(with: self) { owner, lotto in let text = "\(lotto.drwtNo1) / \(lotto.drwtNo2) / \(lotto.drwtNo3) / \(lotto.drwtNo4) / \(lotto.drwtNo5) / \(lotto.drwtNo6) (bonus:\(lotto.bnusNo))"
                        resultText.accept(text)
                    }
                    .disposed(by: owner.disposeBag)
            } onError: { owner, error in
                print("LottoObservable onError", error)
            } onCompleted: { owner in
                print("LottoObservable onCompleted")
            } onDisposed: { owner in
                print("LottoObservable onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(resultText: resultText, showAlert: showAlert, showToast: showToast)
    }
}
