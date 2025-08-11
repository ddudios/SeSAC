////
////  ObservableRemind.swift
////  SeSAC7Week7
////
////  Created by Suji Jang on 8/11/25.
////
//
//import Foundation
//
//// 20. String 타입 뿐만 아니라 다른 타입들도 들어올 수 있는 환경?
//// 30. 코드를 조금 짧게 쓸 수 없나?
//
//class Field {
//    // 2. 데이터가 달라질때 alert, 화면전환 등을 하고 싶어서 함수를 만들고 싶다
////    var action: (() -> Void)?
//    // 31-1.
//    var action: ((String) -> Void)?
//    
//    var text: String {
//        didSet {
//            print("text didSet", oldValue, text)
////            action?()  // 값이 없을 때도 있으니까 ?가 있고, closure가 있으면 didSet 시점에 실행시키겠다
//            // 31-2.
//            action?(text)
//        }
//    }
//    
//    init(_ text: String) {
//        self.text = text
//        print("Field Init")
//    }
//    
//    // 31-2.
////    func playAction(action: @escaping () -> Void) {
//    func playAction(action: @escaping (String) -> Void) {
//        print(#function, "START")
//        
//        // 4. 함수가 들어오면, 그 함수를 실행
////        action()  // 3-2와 같은 역할
//        // 31-3.
//        action(text)
//        
//        // 5. 매개변수로 들어온 기능을 프로퍼티에 넣어주어서, 값이 변경됐을 때도 같은 기능을 실행시켜주고싶다
////        self.action = action
//        
//        
//        print(#function, "END")
//    }
//    
//    // 이는 didSet을 없애기 위한 개념
//}


import Foundation

// 20. String 타입 뿐만 아니라 다른 타입들도 들어올 수 있는 환경?
class Field<T> {
    // 의도적으로 호출하지 못하게 막음
    private var action: ((T) -> Void)?
    
    // 어떤 타입이든 괜찮게 이름 바꿔줌
//    var text: T {
//        didSet {
//            print("text didSet", oldValue, text)
//            action?(text)
//        }
//    }
    
        var value: T {
            didSet {
                print("text didSet", oldValue, value)
                action?(value)  // 바뀐 값
            }
        }
    
    init(_ value: T) {
        self.value = value
        print("Field Init")
    }
    
    func playAction(action: @escaping (T) -> Void) {
        print(#function, "START")
        action(value)
        self.action = action
        print(#function, "END")
    }
}
