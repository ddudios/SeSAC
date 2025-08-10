//
//  WordCountViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/9/25.
//

import Foundation

final class WordCountViewModel {
    var inputText: String = "" {
        didSet {
            updateCharacterCount()
        }
    }
    
    var output = "" {
        didSet {
            closureText?()
        }
    }
    
    var closureText: (() -> Void)?
    
    private func updateCharacterCount() {
        let count = inputText.count
        output = "현재까지 \(count)글자 작성중"
    }
}
