//: [Previous](@previous)

import Foundation

// 1. 사용하기 전에 모두 초기화가 되어 있어야 한다
    // vc의 property를 init하지 않으니까 이슈
// => 초기값을 넣기만 하면 되는데 방법이 다양하다
// 1-1. 클래스의 모든 변수/상수를 초기화 하기
// 1-2. 옵셔널 선언: nil을 포함할 수 있는 상태로, nil(값이 없는 상태)이 들어있음
    // nil이 들어있기 때문에 값을 사용하면 앱이 터질 수 있음
// 1-3. 사용하려는 직전에 초기화해줄 수 없나?
class User {
    var name: String = "Jack"
    var age: Int?
    
    /*
    func changeVale(name: String, age: Int) {
        name = name   // 프로퍼티
        age = age
    }
     */
    
    // 초기화를 위해서 쓰는 함수
    init(name: String, age: Int) {  // 초기화구문, 이니셜라이저
        self.name = name  // 인스턴스 프로퍼티
        self.age = age  // 인스턴스 프로퍼티
    }
    
    func hello() {  // 초기화가 되어야 사용할 수 있다는 의미의 인스턴스 메서드
        print("안녕하세요")
    }
}

// 식판을 공간에 담음
//var jack = User()
//jack.age
//jack.age
//jack.changeVale(name: "Den", age: 11)
//
//jack.name = "Finn"
//jack.age = 33
//jack.name

// User(빈 식판) -> 활용하기 위해서 Jack식판(Den, Fin)선언 -> 초기화 -> 사용  // 인스턴스
var jjjjjack = User(name: "Den", age: 20)  // 시점상 초기화가 무조건 되어이있다
// 인스턴스 만들어짐 = 초기화
jjjjjack.age

// User.age
// 초기화를 해야 age와 name을 사용할 수 있음 == 인스턴스가 있어야 age와 name을 사용할 수 있음 (어딘가에 담아둬야 쓸 수 있다)
// 인스턴스가 있어야 age, name을 사용할 수 있기 때문에 인스턴스 프로퍼티라고 부른다
// 초기화를 해야 쓸 수 있기 때문에 인스턴스 메서드
// 인스턴스 멤버인 age는 (초기화를 해야 사용할 수 있는) 초기화하지 않고 사용할 수 없다

// var/let -> 프로퍼티 -> 인스턴스 프로퍼티 (초기화해야 쓸 수 있음) / 타입 프로퍼티 (초기화와 상관없이 초기화하지 않아도 쓸 수 있음)
// 프로퍼티 + 메서드 = 멤버

// 클래스는 초기화하지 않고 사용하려고 하면 오류 / 구조체는 초기화하지 않아도 오류가 나지 않음(이니셜라이저가 자동으로 만들어져 있음)
struct Mentor {
    var name: String
    var age: Int
}

// 인스턴스 생성
// class는 초기화 구문이 필요한데, struct는 필요하지 않다
    // 왜? 클래스는 상속이 된다
    // struct는 초기화 구문을 자동으로 제공해줘서 굳이 쓸 필요는 없음
    // => Memberwise Initializer 멤버와이저 이니셜라이저 구문: 모든 멤버에 대해서 자동 초기화
    // struct에 init구문은 쓸데없기 때문에 쓰지 않기
let den = Mentor(name: "den", age: 13)

class BabyMonster {
//    let nick
    func attack() {
        print("공격")
    }
}

// BabyMonster공격을 갖고 있게 만들기
class BossMonster: BabyMonster {
    let name = "이름"
    func bigAttack() {
        print("완전큰공격")
    }
}

let m = BossMonster()
m.bigAttack()
m.attack()  // 상속을 받았기 때문에 보스는 빅어택, 작은어택 모두 사용 가능
//let m = BossMonster(name: "fasdf") 이들을 쓰려면 어디까지 초기화가 명확히 되어야 하냐면 보스에는 name밖에 없지만 베이비에는 또다른 프로퍼티가 있을 수 있다. 그 베이비는 또 다른 상속을 받을 수 있기 때문에 클래스는 초기화할 때 생각보다 많은 것들을 고려해야 한다
// 우리 눈에는 보스의 프로퍼티만 초기화하면 될 것같지만, 베이비의 모든 것들도 초기화되어 있어야 한다
// struct는 상속X -> 내꺼만 잘하자 (애플의 입장에서 예상 가능: 상속, 영향받지 않으니 struct는 초기화 구문이 자동으로 만들어질 수 있다)
// class는 내가 사용할 클래스의 것도 초기화되어있어야 하고, 상속받은 부모의 초기화도 되어 있어야 하고, ... 모든 요소들이 초기화되어있어야 함 -> 신경써야할 부분이 훨씬 많아서 명시적으로 써줘야 한다
// 구조체는 내것만 신경쓰면 됨, 몇개만 있는걸 100퍼센트 알고 있는 상황이라서 init이 필요하지 않다

//: [Next](@next)
