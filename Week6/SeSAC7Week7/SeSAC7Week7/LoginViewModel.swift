//
//  LoginViewModel.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/11/25.
//

import Foundation

class LoginViewModel {
    
    // didSet, closure 구문은 숨기고 한 뎁스 깊어짐
    
    // 11. VC -> VM: VC에서 들어온 이벤트
    var inputIdTextField = Field("")
    // String을 Field에 담아놓아서, String을 다이렉트로 넣는 게 아닌 Field로 감싸놓은 형태
    
    // 15-2. 외부로 보내줄 데이터
    var outputValidationLabel = Field("")  // 레이블 글자
    
    // 20. Field를 타입따라 만들어줘야하나?
    // - String이 아닌 어떤 타입이든 사용할 수 있도록 만듦
    var outputTextColor = Field(false)  // 레이블 컬러
    
    // 14.
    init() {
        print("LoginViewModel Init")
        /**
         Field Init  # LoginViewModle인스턴스 생성되려면 Field("")가 초기화되어야 하고 그러니까 Field도 init
         LoginViewModel Init
         */
        
        // 15. 데이터 변경될 때마다 어떤 로직이 실행될지를 action에 정의
//        inputIdTextField.playAction {  // 매개변수 실행과 동시에 프로퍼티에 내용을 넣어줌
//            // 15-4
//            self.validation()
//        }
        // 31.
        inputIdTextField.playAction { _ in
            self.validation()
        }
    }
    
    // 15-1. 어떤 기능?
//    private func validation() {
//        if inputIdTextField.text.count < 4 {
//            // 15-3.
//            outputValidationLabel.text = "4자리 미만입니다"
//            outputTextColor.text = false
//        } else {
//            outputValidationLabel.text = "잘했어요"
//            outputTextColor.text = true
//        }
//    }
    private func validation() {
        if inputIdTextField.value.count < 4 {
            // 15-3.
            outputValidationLabel.value = "4자리 미만입니다"
            outputTextColor.value = false
        } else {
            outputValidationLabel.value = "잘했어요"
            outputTextColor.value = true
        }
    }
}

// ViewModel input 바뀜 -> Field의 didSet
/**
 Field Init
 Field Init
 LoginViewModel Init
 playAction(action:) START
 text didSet  4자리 미만입니다
 playAction(action:) END
 textFieldDidChange()
 text didSet  1
 text didSet 4자리 미만입니다 4자리 미만입니다
 */
// input에 대한 Field의 text의 didSet: text didSet 123 1234
// output에 대한 Field의 text의 didSet: text didSet 4자리 미만입니다 잘했어요
