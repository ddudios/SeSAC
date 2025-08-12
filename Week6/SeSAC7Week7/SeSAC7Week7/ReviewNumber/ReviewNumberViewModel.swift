//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

// 보이는것 외에는 전부 VM (VC에서 User는 입력 -> 그 내용을 온전히 VM이 받아서 데이터 가공 -> 보여줄 내용만 VC에)
final class ReviewNumberViewModel {
    
    // Observable 선언 형태 느낌
    var hello: [String] = []
    var sesac: Array<String> = []
    
    // VC -> VM
    var inputAmount: ReviewObservable<String?> = ReviewObservable(nil)  // VC의 TextField입력값
    // 제네릭 구조에 의해서 타입어노테이션이 없으면 어떤 nil인지 알 수 없어서 오류남
    var outputAmount: ReviewObservable<String> = ReviewObservable("")
    // input달라지면 -> output
    
    init() {
        // 초기화때마다 inputAmount가 바뀔 때마다 해줬으면 하는 내용
        inputAmount.bind {
            print("inputAmount 달라짐")
            
            // 값을 가지고 조건 처리
            //1.
            guard let text = self.inputAmount.value else {  // 클로저문 안에서 사용중이라 self
                // 앞에 굳이 self를 붙이는게 싫어서 메서드로 분리
                print("nil인 상태")
                // 내가 하려는 게 뭔지 생각하기: 화면에 글자 표시하고 싶음
                self.outputAmount.value = ""
                return
            }
            
            //2.
            if text.isEmpty {
                print("값을 입력해주세요")
                self.outputAmount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                print("숫자만 입력해주세요")
                self.outputAmount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                print("₩" + wonResult)
                self.outputAmount.value = "₩" + wonResult
                
                //            let converted = Double(num) / exchangeRate
                //            let convertedFormat = NumberFormatter()
                //            convertedFormat.numberStyle = .currency
                //            convertedFormat.currencyCode = "USD"
                //            let convertedResult = convertedFormat.string(from: converted as NSNumber)
                //            convertedAmountLabel.text = convertedResult
                
            } else {
                print("1,000만원 이하를 입력해주세요")
                self.outputAmount.value = "1,000만원 이하를 입력해주세요"
            }
        }
    }
    
    
    
}
