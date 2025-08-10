//
//  UserViewModel.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/8/25.
//

import Foundation

// Flow 이해: 빌드 → 뷰컨에서 리로드로 함수 전달 → 닐에서 reload프로퍼티에 함수 들어와서 대기 상태 → 아직 함수 실행X → 버튼 누르면 뷰컨 버튼에 의해서 뷰모델은 신호를 받아서 코드를 실행 → 데이터가 달라져서 디드셋 구문 호출 → 대기하고 있던 클로저구문이 이제서야 실행되면서 리로드데이터가 이루어짐

class UserViewModel {
    // ViewController더미데이터에서 온건지 외부에서 온건지 알고싶지 않다
    var list: [Person] = [] {
        didSet {
            // 데이터 변화는 있는데, 데이터바뀌면 리로드해줘야하는데 그걸 안하니까 화면에 안보임 -> 시점을 찾아서 하거나, 클로저로 값전달처럼 리로드
            print(oldValue)
            print(list)
            //tableView.reloadData()  // 뷰컨트롤러에서 이 코드를 작성하는 게 맞겠다
            reload?()
        }
    } /*{
                             // 저장 프로퍼티
                         //    var nickname = "고래밥" {
                         //        didSet { }
                         //    }
                             // 연산 프로퍼티
                         //    var nickname: String {
                         //        get { }
                         //        set { }
                         //        didSet { }
                         //    }
                             
                             // 인스턴스 저장 프로퍼티
                             // 저장/연산 상관없이 변화 신호를 받을 수 있음
                             // 내용이 달라질 때마다 신호를 받고 싶다 { }

        didSet {
            print("list 데이터가 달라졌어요")
            print(oldValue)
            print(list)
            tableView.reloadData()  // list가 달라지면 리로드한다는 것을 저장프로퍼티에 기대게 만들 수 있다
            // 데이터 달라지면 알아서 리로드데이터 -> 데이터 바뀌면 갱신해야지를 하나하나 신경쓰지 않아도 됨
        }
    }*/
    
    // 값바뀐 사실만 알면 돼서, Int와 같이 작은 단위로 트리거를 받음
    // 로드버튼을 눌렀다는 사실만 전달받고 싶다
    // 뷰컨은 0이라는 작은 데이터만 주고 나머지는 뷰모델에서 실행
    var loadTapped = 0 {  // 가짜로 받을 신호를 만들고
        didSet {
            print("loadTapped")
            load()
        }
    }
    // 1에서 1로변하는것도 변한다고 인식하기 때문에 항상 디드셋 호출됨
    // true -> true로도 값이 바뀌는 거기때문에 메서드보단 작은 단위를 뷰컨이 알고있고 값이 바뀌었으니까 호출
    // 뷰컨은 작은 것만 알고 있음 -> 탭됐을 때 뷰모델만 알고 있는 로드버튼 호출
        // 뷰모델에서만 온전히 알고 실행하는 형태
    var resetTapped = "" {
        didSet {
            print("resetTapped")
            reset()
        }
    }
    var addTapped = true {
        didSet {
            print("addTapped")
            add()
        }
    }
    // 아무 의미없이 전달만 해주는 내용을 가장 작은 신호로 뭘 줄 수 있을까?
        // 매개변수, 반환값도 없는 비어있는 튜플 타입을 전해주는 것도 가능 Void: ()
        // var resetTapped = () {
    
    var reload: (() -> Void)?
    // 뭐가 들어올지는 모르겟는데 들어오면 reload는 리스트가 달라졌을 때 실행시켜주고싶다
    
    
    init() {
        //인스턴스 생성 시기 확인
        print("UserViewModel Init")
        // 씬델리게이터에서 ()로 만들어질 때, 모든 프로퍼티가 초기화돼야 뷰컨이 만들어질 수 있고 그 내부 뷰모델도 초기화
        // 초기화할때 리스트 배열이 빈배열이기 때문에 처음에 아무 내용도 안뜸
        load() // 호출하면 빌드하자마자, 이닛할때 로드, 리스트에 데이터 추가, 기존 데이터 보임
    }
    
    func cellForRowAtData(indexPath: Int) -> String {
        // indexPath.row
        let data = list[indexPath]
        return "\(data.name), \(data.age)세"
    }
    
    private func load() {
        list = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        list.removeAll()
    }
    
    private func add() {
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.append(jack)
    }
}
