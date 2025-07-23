//
//  PurpleTextField.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
/*
protocol Hello {  // 메서드, 프로퍼티, 초기화 구문도 정의 가능
    init()  //
    func welcome()
}

class Jack: Hello {
    func welcome() {
        
    }
    
    required init() {
        // init구문은 프로토콜 안에 정의되어있구나
    }
    
    let name: String
    let age: Int
//    let a = PurpleTextField()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}*/

// UITextField를 상속받은 PurpleTextField 구성
class PurpleTextField: UITextField {
    // 인스턴스를 만들어줄 때 모든 속성들이 정의됐으면 좋겠다
//    init() {  // awakeFromNib과 비슷함
//        self.borderStyle = .none
//    }
    
    // :UITextField가 없었다면 init() {}로 할 수 있다
    // UITextField를 상속받고 있으면 부모가 가지고 있는게 있으니까 하라는거 웬만하면 해야한다
    // 코드로 뷰를 구성했을 때 실행되는 초기화 구문
    // 이 구문은 없어도 오류가 뜨지 않음
    // 따라서 이거는 상속을 통해서 온 것이고
    override init(frame: CGRect) {
        super.init(frame: frame)  // override일때 super의 init을 불러야 한다
        
        print("코드 Init")
        // 자식이 재정의도고 있기 때문에
        self.borderStyle = .none
        self.font = .boldSystemFont(ofSize: 15)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemPurple.cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
        self.tintColor = .systemPurple
    }
    
    // 스토리보드로 뷰를 구성했을 때 실행되는 초기화 구문
        // 스토리보드를 활용했다면 이게 실행된다
        // 코드로 만들더라도 스토리보드 초기화 구문은 꼭 쓰게끔 애플이 만들어 놓음 (없으면 에러)
    // 이것은 프로토콜을 통해서 온 것이다
        // required 키워드는 프로토콜에 있다는 걸 알려주는 역할
    /*
    required init?(coder: NSCoder) {
        // 절대 호출이 안될 거기 때문에 지우고 Fix
        print("스토리보드 Init")
    }*/
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")  // fatalError가 있으면 런타임 에러가 생기는 코드
        // 코드베이스일때는 실행되지 않을 구문
    }
}

