//
//  SearchViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation
import RxSwift
import RxCocoa

// input/output/데이터가공 관점
final class SearchViewModel: RxViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    struct RxInput {
        let searchBarTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct RxOutput {
        let list: BehaviorRelay<[Item]>
    }
    
    func transform(rxInput: RxInput) -> RxOutput {
        let list: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
        
        rxInput.searchBarTap
            .withLatestFrom(rxInput.searchText)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .distinctUntilChanged()
            .flatMapLatest { text -> Observable<Result<NaverSearch, NetworkError>> in
                CustomObservable.callRequest(api: NaverRouter.search(query: text, start: 1, display: 30, sort: SortType.accuracy.rawValue))
            }
            .subscribe(with: self) { owner, response in
                print("@@@@@@@", response)
                switch response {
                case .success(let value):
                    let data = value.items
                    var listValue = list.value
                    listValue.append(contentsOf: data)
                    list.accept(listValue)
                case .failure(let error):
                    switch error {
                    case .noInternet:
                        print("인터넷 연결을 확인하세요")
                    case .error:
                        print("네트워크 통신 실패")
                    }
                }
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)

        
        return RxOutput(list: list)
    }
    
    var input: Input
    var output: Output
    
    struct Input {
        var viewDidLoad: SwiftCustomObservable<Void> = SwiftCustomObservable(())
        var textField: SwiftCustomObservable<String?> = SwiftCustomObservable(nil)
        var searchBarSearchButtonClicked = SwiftCustomObservable(())
    }
    
    struct Output {
        var text = SwiftCustomObservable("")
        var searchBarSearchButtonClicked = SwiftCustomObservable("")
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoad.bind {
            self.resetText()
        }
        
        input.searchBarSearchButtonClicked.lazyBind { _ in
            self.validate()
        }
    }
    
    private func resetText() {
        output.text.data = ""
    }
    
    private func validate() {
        guard let text = input.textField.data else {
            print("error: \(#function) - inputTextField: nil")
            return
        }
        
        if text.count > 1 {
            self.output.searchBarSearchButtonClicked.data = text
        } else {
            print("error: \(#function) - 2글자 이상 입력해야 합니다")
        }
    }
}
