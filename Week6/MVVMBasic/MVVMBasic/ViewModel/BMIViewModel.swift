//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/10/25.
//

import Foundation

enum BmiValidationError: Error {
    case emptyString
    case outOfRange
    case isNotDouble
}

class BMIViewModel {
//    var inputHeight: String? = "" {
//        didSet {
//            validate()
//        }
//    }
//    
//    var inputWeight: String? = "" {
//        didSet {
//            validate()
//        }
//    }
//    
//    var outputText = "" {
//        didSet {
//            closureText?()
//        }
//    }
//    
//    var outputAlertTitle = "" {
//        didSet {
//            closureAlert?()
//        }
//    }
//    
//    var closureText: (() -> Void)?
//    var closureAlert: (() -> Void)?
        
    // 관찰할 데이터
    var inputHeight = Observable("")
    var inputWeight = Observable("")
    var outputText = Observable("여기에 결과를 보여주세요")
    var outputAlertTitle = Observable("")
    
    // 초기화 시점에 input 기능 활성화
    init() {
        inputHeight.binding { _ in
            self.validate()
        }
        
        inputWeight.binding { _ in
            self.validate()
        }
    }
        
    private func validate() {
        // Observable의 data는 더이상 Optional타입이 아니기 때문에 nil 판단 필요없음
        do {
            let message = try validateUserInput(heightText: inputHeight.data, weightText: inputWeight.data)
            outputText.data = message
        } catch let error {
            switch error {
            case BmiValidationError.emptyString:
                outputAlertTitle.data = "키 또는 몸무게를 입력해 주세요"
            case BmiValidationError.isNotDouble:
                outputAlertTitle.data = "숫자로 입력해 주세요"
            case BmiValidationError.outOfRange:
                outputAlertTitle.data = "키는 50~300, 몸무게는 10~300 사이로 입력해주세요"
            default:
                print("error: \(error)")
            }
        }
    }
    
    private func validateUserInput(heightText: String, weightText: String) throws -> String {
        if heightText == "" {
            throw BmiValidationError.emptyString
        }
        
        if weightText == "" {
            throw BmiValidationError.emptyString
        }
        
        guard let height = Double(heightText) else {
            throw BmiValidationError.isNotDouble
        }
        
        guard let weight = Double(weightText) else {
            throw BmiValidationError.isNotDouble
        }
        
        if height < 50 || height > 300 {
            throw BmiValidationError.outOfRange
        }
        
        if weight < 10 || weight > 300 {
            throw BmiValidationError.outOfRange
        }
        
        return "올바른 입력: 키(\(height)), 몸무게(\(weight))"
    }
}
