//: [Previous](@previous)

import UIKit

// 몬스터1
var name = "몬스터"  // 선언, 초기화
var level = 1
var power = 100

// 몬스터2: 클래스/구조체를 모른다면 몬스터 2마리를 만들고 싶으면 다 다른 변수명으로 만들어야 한다
var name2 = "몬스터"
var level2 = 1
var power2 = 100

// 몬스터3
var name3 = "몬스터"
var level3 = 1
var power3 = 100
// 맵에 3마리만 있으면 괜찮은데 몇천마리 있으면 관리하기 쉽지 않다
// 각각 따로가 아니라 하나의 덩어리로 관리하고 싶다 -> 클래스/구조체

/*
// 모든 프로퍼티 선언
class Monster {
    let name = "몬스터"
    let level = 1
    let power = 100
}

// 몬스터 공간 안에 몬스터 클래스 생성
var monster1 = Monster()  // 선언, 인스턴스 생성(초기화)
var monster2 = Monster()
var monster3 = Monster()
 */

// 클래스가 가진 모든 프로퍼티는 초기화가 되어 있어야 한다
class Monster {
    // 타입 프로퍼티(static 키워드): 인스턴스 생성과 상관없이 접근할 수 있는 프로퍼티
    static let game: String = "바람의 나라"  // 타입 프로퍼티 - 각각의 공간 안에 같은 문자열을 넣을 것이라면,
    let name: String  // 인스턴스 프로퍼티: 인스턴스를 생성한 다음에 접근할 수 있어서
    let level: Int  // 인스턴스 프로퍼티
    let power: Int  // 인스턴스 프로퍼티
    
    init(name: String, level: Int, power: Int) {
        self.name = name
        self.level = level
        self.power = power
    }
}

// 하나씩 꺼내서 수정해도 되지만 여러개면 힘드니까 init구문을 활용해 한번에 해결
// 몬스터1 공간이 만들어지기 전에 모든 값이 초기화
// Monster 클래스를 사용하기 위해서 공간(easy)을 만듦
// 공간 = 인스턴스를 생성했다 (초기화를 했다 - 모두 초기화한 건 아닐 수 있기 때문에 인스턴스를 생성했다고 한다)
// 인스턴스를 생성하고 나면, 인스턴스를 통해 프로퍼티와 메서드에 접근할 수 있다.
// easy의 name공간과 normal의 name공간은 다른 공간이다
var easy = Monster(name: "쉬운 몬스터", level: 1, power: 1)
var normal = Monster(name: "보통 몬스터", level: 10, power: 10)
var hard = Monster(name: "어려운 몬스터", level: 100, power: 100)
Monster.game
// easy, normal, hard 3개의 공간을 만들면 3개의 공간이 생길것이고 3개의 인스턴스가 생기는데, 인스턴스 안에 들어있는 프로퍼티는 name, level, power밖에 없다
// 인스턴스를 통해서 접근하는 것이 아니기 때문에 별도의 공간을 가진다
// 아무리 많은 인스턴스를 만들어도 바람의나라라는 game공간은 하나밖에 없다

let nickname = "고래밥"
var subNickname = nickname
print(nickname, subNickname)  // 고래밥 고래밥

subNickname = "칙촉"
print(nickname, subNickname)  // 고래밥 칙촉

class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let person = User(name: "jack")
let guest = person
print(person.name, guest.name)  // jack jack

guest.name = "finn"
print(person.name, guest.name)  // finn finn


//: [Next](@next)
