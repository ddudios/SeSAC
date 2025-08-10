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

class AgeViewModel {
    
    // input
    var inputTextField: String? = "" {
        didSet {
            validate()
        }
    }
    
    // output
    var outputText = "" {
        didSet {
            closureText?()  // output글자가 바뀌면 실행
        }
    }
    
    var closureText: (() -> Void)?  // 뿌려주기 기능 클로저 선언
    
    // 데이터 가공
    private func validate() {
        guard let text = inputTextField else {
            outputText = "텍스트필드 글자: nil"  // 뷰에 표시할 내용
            return
        }
        
        do {
            let result = try validateUserInput(text: text)
            outputText = result
        } catch let error {
            switch error {
            case AgeValidationError.isNotInt:
                outputText = "숫자만 기입 가능합니다"
            case AgeValidationError.outOfRange:
                outputText = "1~100세만 기입 가능합니다"
            default:
                print(#function, error)
            }
        }
    }
    
    private func validateUserInput(text: String) throws -> String {
        guard let age = Int(text) else {
            throw AgeValidationError.isNotInt
        }
        
        print(age)
        
        if age < 1 || age > 100 {
            throw AgeValidationError.outOfRange
        }
        
        return "올바른 나이 입력: \(age)"
    }
}
