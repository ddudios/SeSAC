//: [Previous](@previous)

import Foundation

class Mentor {
    func mentoring() {
        print("멘토링 하세요")
    }
}

class Den: Mentor {
    func study() {
        print("공부하기")
    }
    
    // 부모에 같은 이름의 함수가 있다면 구분이 필요하다
    // 부모클래스에도 이 메서드가 있다
    // 기본으로 부모클래스의 것까지 실행되지는 않는다: override는 재정의니까
    override func mentoring() {  // 부모클래스에 있는 걸 연이어서 뭔가 하는구나
        
        super.mentoring()
        // 쓸 수도 있고 안 쓸 수도 있다
        // 이 함수를 쓰는지 여부에 따라 실행되는 범위도 달라진다
        
        print("화이팅하세요")
    }
}

let den = Den()  // 인스턴스 생성
den.mentoring()
den.study()



//: [Next](@next)
