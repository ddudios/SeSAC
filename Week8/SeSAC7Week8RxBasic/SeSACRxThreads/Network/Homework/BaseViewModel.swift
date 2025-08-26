//
//  BaseViewModel.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/26/25.
//

import Foundation

/**
 struct 사용이 프로토콜 내에서 불가능하므로 제네릭 사용
 - Input, Output에 들어가는 내용이 항상 다름
 - ViewModeldml input, output 구조체 구조가 모두 다르니 제네릭을 도입해야겠군!
     // 프로토콜은 제네릭 <>구조를 쓸 수 없음
#associatedType을 제네릭 대신 써보자
 */
class A {
    struct User {
        let name: String
    }
}

class B {
    struct User {
        let age: Int
    }
}

//extension UIViewController {
//    associatedtype Jack  // 프로토콜 내에서만 사용 가능
//    func total/*<Jack: Numeric>*/(a: Jack, b: Jack) {
//        return a + b
//    }
//}

protocol BaseViewModel {   // 어떻게 구조화, 추상화했는지 코드의 의도가 명확하다고 리드미에 작성하면 큰 힘을 발휘할 수 있음
//    struct Input { }
//    struct Output { }
    associatedtype Jack  // Input
    associatedtype Finn  // Output
    
    func transform(input: Jack) -> Finn  // 해당 위치로 들어감
    
    // 다른 이름으로 써도 되지만 명확하게 써주자
    associatedtype Input
    associatedtype Output
}

class Example: BaseViewModel {
    
    // 굳이 명세하면 프로토콜 문법 어떻게 쓸 줄 모르는구나 생각할 수 있음 (생략하는 것을 선호)
//    typealias Jack = Input  // Jack을 Input struct로 쓰기로 한 거구나
//    typealias Finn = Output
    
    struct Input {
        let name: String
    }
    
    struct Output {
        let age: Int
    }
    
    func transform(input: Input) -> Output {  // 명세하는 순간 typealias도 사용하지 않아도 됨
        return Output(age: 10)
    }
//    func transform(input: Jack) -> Finn {  // 타입엘리어스로 써도됨
//        return Output(age: 10)
//    }
    
    /** 또는
    typealias Jack = Input
    typealias Finn = Output
    
    struct Input {
        let name: String
    }
    
    struct Output {
        let age: Int
    }
     
    func transform(input: Jack) -> Finn {  // 타입엘리어스로 써도됨
        return Output(age: 10)
    }
    */
}
