//
//  Currency.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/9/25.
//

import Foundation

class CurrencyViewModel {
    // input
    var inputTextField: String? = "" {
        // 데이터 가공
        didSet {
            validate()
        }
    }
    
    // output
    var outputText = "" {
        didSet {
            closureText?()  // 실행
        }
    }
    
    // 뿌려주기 클로저
    var closureText: (() -> Void)?  // 선언
    
    private func validate() {
        guard let text = inputTextField else {
            outputText = "nil"
            return
        }
        guard let amount = Double(text) else {
            outputText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        
        outputText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
