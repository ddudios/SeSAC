//
//  SearchViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

// input/output/데이터가공 관점
final class SearchViewModel {
    var inputViewDidLoadTrigger: Observable<Void> = Observable(())
    var inputTextField: Observable<String?> = Observable(nil)
    var inputSearchBarSearchButtonClickedTrigger = Observable(())
    
    var outputText = Observable("")
    var outputSearchBarSearchButtonClicked = Observable("")
    
    init() {
        inputViewDidLoadTrigger.bind {
            self.resetText()
        }
        
        inputSearchBarSearchButtonClickedTrigger.bind { _ in
            self.validate()
        }
    }
    
    private func resetText() {
        outputText.data = ""
    }
    
    private func validate() {
        guard let text = inputTextField.data else {
            print("error: \(#function) - inputTextField: nil")
            return
        }
        
        if text.count > 1 {
            self.outputSearchBarSearchButtonClicked.data = text
        } else {
            print("error: \(#function) - 2글자 이상 입력해야 합니다")
        }
    }
}
