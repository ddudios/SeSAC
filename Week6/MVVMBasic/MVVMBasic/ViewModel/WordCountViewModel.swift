//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/9/25.
//

import Foundation

final class WordCountViewModel {
//    var inputText: String = "" {
//        didSet {
//            updateCharacterCount()
//        }
//    }
//    
//    var output = "" {
//        didSet {
//            closureText?()
//        }
//    }
//    var closureText: (() -> Void)?
    
    var inputText = Observable("")
    var outputText = Observable("")
    
    init() {
        inputText.binding { _ in
            self.updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        let count = inputText.data.count
        outputText.data = "현재까지 \(count)글자 작성중"
    }
}
