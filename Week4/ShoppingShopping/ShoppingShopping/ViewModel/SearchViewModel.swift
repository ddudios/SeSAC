//
//  SearchViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

// input/output/데이터가공 관점
final class SearchViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var viewDidLoad: Observable<Void> = Observable(())
        var textField: Observable<String?> = Observable(nil)
        var searchBarSearchButtonClicked = Observable(())
    }
    
    struct Output {
        var text = Observable("")
        var searchBarSearchButtonClicked = Observable("")
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
