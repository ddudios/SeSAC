//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/10/25.
//

import Foundation

enum BirthValidationError: Error {
    case outOfRangeYear
    case outOfRangeMonth
    case outOfRangeDay
    case isNotInt
}

class BirthDayViewModel {
    
    // input
    var inputYear = Observable("")
    var inputMonth = Observable("")
    var inputDay = Observable("")
    
    init() {
        inputYear.binding { _ in
            self.validate()
        }
        
        
        inputMonth.binding { _ in
            self.validate()
        }
        
        
        inputDay.binding { _ in
            self.validate()
        }
    }
    
    // output
    var outputText = Observable("")
    
    // 데이터 가공
    private func validate() {
        do {
            try birthValidateUserInput(yearString: inputYear.data, monthString: inputMonth.data, dayString: inputDay.data)
        } catch let error {
            switch error {
                
            case .outOfRangeYear:
                outputText.data = "입력 가능 범위: 1700 <= year <= 2025"
            case .outOfRangeMonth:
                outputText.data = "입력 가능 범위: 1 <= month <= 12"
            case .outOfRangeDay:
                outputText.data = "입력 가능 범위: 1 <= day <= 31"
            case .isNotInt:
                outputText.data = "입력 가능 타입: Int"
            }
        }
    }
    
    private func birthValidateUserInput(yearString: String, monthString: String, dayString: String) throws(BirthValidationError) {
        if let year = Int(yearString),
           let month = Int(monthString),
           let day = Int(dayString) {
            
            if year < 1700 || year > 2025 {
                throw BirthValidationError.outOfRangeYear
            } else if month < 1 || month > 12 {
                throw BirthValidationError.outOfRangeMonth
            } else if day < 1 || day > 31 {
                throw BirthValidationError.outOfRangeDay
            } else {
                outputText.data = "D + \(birthday(year: year, month: month, day: day))"
            }
        } else {
            outputText.data = "숫자를 입력해주세요"
        }
    }
    
    private func birthday(year: Int, month: Int, day: Int) -> Int {
        let birthComponents = DateComponents(year: year, month: month, day: day)
        let birthday = Calendar.current.date(from: birthComponents)!
        return Calendar.current.dateComponents([.day], from: birthday, to: Date()).day ?? 0
    }
}
