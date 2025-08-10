//
//  NumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/8/25.
//

import Foundation

// Input: 텍스트필드 글자
// 네트워크통신, 옵션판단 등의 로직
// Output: 결과 글자, color

class NumberViewModel {
    
    // VC에서 VM로 들어오는 정보
    // textField에 들어오는 정보
    var inputField: String? = "" {  // = ""
        didSet {
            print("inputField")
            print(oldValue)
            print(inputField)
            validate()  // 호출
        }
    }
    // nil처리도 로직 아니냐 그럼 뷰컨에 있는게 맞냐
    // 옵셔널 덜어주는것정도는 비즈니스로직이 얼마나 많은데 그정도는 뷰컨이 해야지
    // 개발자마다 뷰모델의 로직은 다 다르다
        // 뷰컨이 어디까지 담당하는게 좋을까를 생각하면서 로직을 짜야한다
    // 옵셔널 핸들링도 뷰모델이 해야한다고 생각해서 이렇게 진행
    
    // VM에서 VC로 보내줄 최종 정보
    var outputText = "" {  // 전달
        didSet {
            print("outputText")
            print(oldValue)
            print(outputText)
            
            closureText?()
            // label.text = outputText
            
            closureColor?()
        }
    }
    
    // UIKit import해버리자
    // "red"문자열로 받자
    // true -> .red / false -> .blue
    // UIKit import하지 않고, false라면 red, true라면 blue라고 스스로 정해놓고 진행
    var outputColor = false {
        didSet {
            print("outputColor")
            print(oldValue)
            print(outputColor)
//            label.textColor = outputColor == false ? .red : .blue
        }
    }
    
    var closureText: (() -> Void)?  // 글자 달라지면 실행
    var closureColor: (() -> Void)?
    
    
    // 일단 전체 코드 가져오기
    private func validate() {  // 변경
        //1) 옵셔널
        // 텍스트필드 글자가 뭔지 알아야 뷰모델이 판단할 수 있다
//        guard let text = amountTextField.text else {
        guard let text = inputField else {
//            formattedAmountLabel.text = ""
            outputText = ""
            
//            formattedAmountLabel.textColor = .red
            outputColor = false
            return
        }
        
        //2) Empty
        if text.isEmpty {
//            formattedAmountLabel.text = "값을 입력해주세요"
            outputText = "값을 입력해주세요"
//            formattedAmountLabel.textColor = .red
            outputColor = false
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
//            formattedAmountLabel.text = "숫자만 입력해주세요"
            outputText = "숫자만 입력해주세요"
//            formattedAmountLabel.textColor = .red
            outputColor = false
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
//            formattedAmountLabel.text = "₩" + result
            outputText = "₩" + result
//            formattedAmountLabel.textColor = .blue
            outputColor = true
        } else {
//            formattedAmountLabel.text = "백만원 이하를 입력해주세요"
            outputText = "백만원 이하를 입력해주세요"
//            formattedAmountLabel.textColor = .red
            outputColor = false
        }
    }
}
