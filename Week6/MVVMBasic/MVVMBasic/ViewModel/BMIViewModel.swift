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
    var inputHeight: String? = "" {
        didSet {
            validate()
        }
    }
    
    var inputWeight: String? = "" {
        didSet {
            validate()
        }
    }
    
    var outputText = "" {
        didSet {
            closureText?()
        }
    }
    
    var outputAlertTitle = "" {
        didSet {
            closureAlert?()
        }
    }
    
    var closureText: (() -> Void)?
    var closureAlert: (() -> Void)?
    
    private func validate() {
        guard let heightString = inputHeight,
              let weightString = inputWeight else {
            outputAlertTitle = "input: nil"
            return
        }
        
        do {
            let message = try validateUserInput(heightText: heightString, weightText: weightString)
            outputText = message
        } catch let error {
            switch error {
            case BmiValidationError.emptyString:
                outputAlertTitle = "키 또는 몸무게를 입력해 주세요"
            case BmiValidationError.isNotDouble:
                outputAlertTitle = "숫자로 입력해 주세요"
            case BmiValidationError.outOfRange:
                outputAlertTitle = "키는 50~300, 몸무게는 10~300 사이로 입력해주세요"
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
