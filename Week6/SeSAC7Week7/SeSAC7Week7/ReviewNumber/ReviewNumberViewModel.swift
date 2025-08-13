//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

/*
// 바깥에 만들어도 됨
struct Input {
    var amount: ReviewObservable<String?> = ReviewObservable(nil)  // VC의 TextField입력값
}

// 뷰모델에서 뷰컨으로 보여질 값
struct Output {
    // 제네릭 구조에 의해서 타입어노테이션이 없으면 어떤 nil인지 알 수 없어서 오류남
    var amount: ReviewObservable<String> = ReviewObservable("")
    // input달라지면 -> output
}

// 외부에서 커스텀 버튼을 만들어서 뷰컨에서 사용하는 것과 같은 느낌
class jackButton: UIButton {
    
}
 */


// 보이는것 외에는 전부 VM (VC에서 User는 입력 -> 그 내용을 온전히 VM이 받아서 데이터 가공 -> 보여줄 내용만 VC에)
final class ReviewNumberViewModel {
    
//    let button = jackButton()  // 외부에서 커스텀 버튼을 만들어서 뷰컨에서 사용하는 것과 같은 느낌
    
    /**
     꼭 해야하는 일은 아님: Input/Output
     - 변수명 앞에 input/output을 적지 않으면 뭐가 input인지 output인지 헷갈린다
     - VM에 Input, Output 프로퍼티가 너무 많이 생김
     - 변수명에 input/output prefix 필요없어짐
     - 서로 그룹이 나뉘기 때문에 input과 output의 변수명이 같아도 됨
    Group을 하나 더 만들어보자!
    */
    
    // 인스턴스로 만들어서 뷰모델이 접근할 수 있는 프로퍼티를 2개로 나뉨
    var input: Input
    var output: Output
//    var input = Input() init에서 하지 않고 바로 선언과 초기화를 함께 해도 되는데 나중에 내용이 많아지면 나누는게 편해짐
    
    /**
     바깥에 만들어도 됨
     - 다른 파일에서 struct Input { }을 만드려니까 유효하지 않은 재선언
     - 다른 파일에서 이들을 쓰지 않을 거고 (클래스 내부에서 사용하는 범위)
     - 다른 파일에서 같은 기능을 할 구조체를 만들 때 또 이름을 지어야함
     */
    // 뷰컨에서 뷰모델로 들어온 값
    struct Input {
        var amount: ReviewObservable<String?> = ReviewObservable(nil)  // VC의 TextField입력값
    }
    
    // 뷰모델에서 뷰컨으로 보여질 값
    struct Output {
        // 제네릭 구조에 의해서 타입어노테이션이 없으면 어떤 nil인지 알 수 없어서 오류남
        var amount: ReviewObservable<String> = ReviewObservable("")
        // input달라지면 -> output
    }
    
    init() {
        // 인스턴스가 만들어져야 인스턴스 프로퍼티 만들어지기 때문에 뷰모델 init에 인스턴스 생성을 가장 처음에 해줘야 한다
        input = Input()  // 인스턴스를 input에 넣어서 초기화시켜줌
        output = Output()
        
        // 초기화때마다 inputAmount가 바뀔 때마다 해줬으면 하는 내용
        input.amount.bind {  // 닷신텍스만 많아질 뿐 코드가 크게 바뀌지는 않음, 코드를 명확하게 보기 위해서 조금 더 구조를 만들어줬을 뿐
            print("inputAmount 달라짐")
            
            // 값을 가지고 조건 처리
            //1.
            guard let text = self.input.amount.value else {  // 클로저문 안에서 사용중이라 self
                // 앞에 굳이 self를 붙이는게 싫어서 메서드로 분리
                print("nil인 상태")
                // 내가 하려는 게 뭔지 생각하기: 화면에 글자 표시하고 싶음
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            // VM: init에서 nil이면 출력하는 input에 의해 -> output값변경: "" -> VC: output의 bind에 의해 화면에 ""표시 -> VM: "값을 입력해주세요"
            
            //2.
            if text.isEmpty {
                print("값을 입력해주세요")
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                print("숫자만 입력해주세요")
                self.output.amount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                print("₩" + wonResult)
                self.output.amount.value = "₩" + wonResult
                
                //            let converted = Double(num) / exchangeRate
                //            let convertedFormat = NumberFormatter()
                //            convertedFormat.numberStyle = .currency
                //            convertedFormat.currencyCode = "USD"
                //            let convertedResult = convertedFormat.string(from: converted as NSNumber)
                //            convertedAmountLabel.text = convertedResult
                
            } else {
                print("1,000만원 이하를 입력해주세요")
                self.output.amount.value = "1,000만원 이하를 입력해주세요"
            }
        }
    }
    
    
    
}
