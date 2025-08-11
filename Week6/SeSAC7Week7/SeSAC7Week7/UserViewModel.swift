//
//  UserViewModel.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/8/25.
//

import Foundation

// Flow 이해: 빌드 → 뷰컨에서 리로드로 함수 전달 → 닐에서 reload프로퍼티에 함수 들어와서 대기 상태 → 아직 함수 실행X → 버튼 누르면 뷰컨 버튼에 의해서 뷰모델은 신호를 받아서 코드를 실행 → 데이터가 달라져서 디드셋 구문 호출 → 대기하고 있던 클로저구문이 이제서야 실행되면서 리로드데이터가 이루어짐

class UserViewModel {

    // VC -> VM
    let loadButtonTapped: Field<Void> = Field(())  // 아무 의미없이 클릭했다는 사실만 전해줌(트리거만 주는 역할)
    let resetButtonTapped = Field(())
    let addButtonTapped = Field(())
    
    // 내가 사용할 타입
    let list: Field<[Person]> = Field([])
    
    init() {
        print("UserViewModel Init")
        loadButtonTapped.playAction { _ in
            self.load()  // 인스턴스 생성될 때, 필드전달 + 디드셋에서 실행
        }
        
        // 이거 바뀌면
        resetButtonTapped.playAction { _ in
            // 이거 할래
            self.reset()
        }
        
        addButtonTapped.playAction { _ in
            self.add()
        }
    }
    
    private func load() {
        list.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        list.value.removeAll()
    }
    
    private func add() {
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.value.append(jack)
    }
    
    func cellForRowAtData(indexPath: Int) -> String {
        let data = list.value[indexPath]
        return "\(data.name), \(data.age)세"
    }
}
