//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/10/25.
//

import Foundation

enum AgeValidationError: Error {
    case outOfRange
    case isNotInt
}

final class AgeViewModel {
    
    // input
    var inputTextField = Observable("")
    
    init() {
        inputTextField.binding { _ in
            self.validate()
        }
    }
    
    // output
    var outputText = Observable("")
    
    // 데이터 가공
    private func validate() {
        do {
            let result = try validateUserInput(text: inputTextField.data)
            outputText.data = result
        } catch let error {
            switch error {
            case AgeValidationError.isNotInt:
                outputText.data = "숫자만 기입 가능합니다"
            case AgeValidationError.outOfRange:
                outputText.data = "1~100세만 기입 가능합니다"
            default:
                print(#function, error)
            }
        }
    }
    
    private func validateUserInput(text: String) throws -> String {
        guard let age = Int(text) else {
            throw AgeValidationError.isNotInt
        }
        
        if age < 1 || age > 100 {
            throw AgeValidationError.outOfRange
        }
        
        return "올바른 나이 입력: \(age)"
    }
}
