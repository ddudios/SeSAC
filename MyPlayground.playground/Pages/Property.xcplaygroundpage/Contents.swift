//: [Previous](@previous)

import Foundation

// 인스턴스를 생성하지 않았다면 name, age를 부를 수 없음 / 인스턴스 프로퍼티는 인스턴스가 생성되어야 사용 가능

// let/var: class Vs. struct
class User {
    let name: String
    var age: Int
    
    // 상속 - 부모클래스의 프로퍼티까지 모두 초기화되어있어야하기 때문
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct Person {
    let name: String
    var age: Int
    
    // memeberwiser initializer
}

//(11:50 그림 직접 그려보기)
let jack = User(name: "J", age: 11)  // class
//jack.name = "D"  // 저장프로퍼티, 인스턴스프로퍼티
jack.age = 55

var person = Person(name: "F", age: 12)  // struct
//person.name = "J"
person.age = 44

// 연산 프로퍼티
struct Food {
    let title: String  // 저장, 인스턴스
    var totalMoney: Int  // 저장, 인스턴스
    
    var order: Int {  // 연산, 인스턴스
        get {
            return totalMoney / 5000  // 지금까지 몇그릇 팔았는지 알 수 있음
                // self 인스턴스를 의미 (굳이 필요하지 않으니 생략)
        }
        set {
            totalMoney += (newValue * 5000)  // newValue = 비어있는 네모박스이자 넣어주는 값이 들어오는 곳
//            self.owner = "Jack"  // error: 오너는 인스턴스프로퍼티가 아니니까 self가 생략되어있다는 가정하에서도 타입프로퍼티면 인스턴스가 아님을 명세해줘야하지 않겠니?
            Food.owner = "Jack"
                // 인스턴스 연산 프로퍼티(order)에 타입 저장 프로퍼티(owner)를 활용할 수도 있다
                // 인스턴스가 언제 생기던 타입프로퍼티는 언제든지 사용할 수 있기 때문
        }
    }
    
    // 인스턴스 프로퍼티는 인스턴스가 생성된 이후부터 접근이 가능
    // den인스턴스가 많아질수록 공간이 무수히 많아짐
    // 타입 프로퍼티는 인스턴스의 생성과는 상관없이 생성 전, 후 아무때나 접근해서 사용할 수 있음 (12:05)
    // static은 한군데에서 생성되어 사용할 수 있고, 인스턴스 조회와 상관없이 할 수 있다
    static let phone = "010-3333-5555"  // 등호가 있기 때문에 저장프로퍼티면서, static이기 때문에 타입프로퍼티
        // 푸드 하나의 공간 ~~~?? : 인스턴스 생성과 상관없이
    
    static var owner = "Den"
}

struct Restaurant {
    static let title = "Jack"  // (12:19)인스턴스생성시점과 상관없이 항상 접근가능해야하기 때문에 늘 값을 가지고 있어야 한다
    var totalMoney = 0
    
    // 타입 연산 프로퍼티에 인스턴스 저장 프로퍼티를 활용할 수는 없다
        // 타입프로퍼티는 인스턴스생성과 상관없이 언제든 접근할 수 있음 (캡쳐12:24)
        // order는 인스턴스생성 전에 사용할 수 있지만 totalMoney는 인스턴스 생성 이후에만 사용할 수 있으니까
        // order는 인스턴스생성 전에도 사용할 수 있어야하기 때문에 오류
    /*
    static var order: Int {
        get {
            return totalMoney / 5000
        }
        set {
            totalMoney += (newValue * 5000)
        }
    }*/
    
    static func bcd() {
        
    }
}

//Restaurant.order  // 인스턴스를 통하지 않고 타입 그 자체를 통해서 접근 가능
// 모두 한 공간을 통해서 사용할 수 있도록 구성할 수 있다

Food.phone
Food.owner

var den = Food(title: "덴마카세", totalMoney: 0)
//den.totalMoney = 5 * 5000

den.order  // 몇그릇팔았는지

den.order = 5  // error: get만 있는데 어떻게 set을 해줄 수 있겠어
    //goButton.currentTitle = "daf"  // get-only 프로퍼티인데 어떻게 값을 넣어줄 수 있겠냐
den.order = 3  // 여기만 봤을 때는 저장/연산 프로퍼티 구분하기 쉽지 않지만 내부는 order가 저장프로퍼티를 변경시켜주고 있다
den.order = 1

print(den.totalMoney)
print(den.order)

Food.owner = "Jack"
Food.owner  // 공간을 하나만 사용하는구나: 인스턴스프로퍼티는 생성된 여러의 공간 중 하나의 공간만 변경되지만 타입프로퍼티는 전체 변경


//: [Next](@next)
