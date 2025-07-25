//
//  ViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

/*
 // self
class User {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}*/

class ViewController: UIViewController {

    @IBOutlet var goFriendButton: UIButton!  // 인스턴스
    @IBOutlet var presentTestButton: UIButton!  // 인스턴스
    @IBOutlet var pushTestButton: UIButton!  // 인스턴스
    
    /*
    // self
    let testButton = UIButton()  // 인스턴스
    let user = User(name: "jack", age: 11)  // user 인스턴스 프로퍼티 => 초기화 된 것: 인스턴스*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self: 자기 자신의 인스턴스를 의미
        self.configureBackgroundColor()  // self 안 써도 되기 때문에 생략
        
        goFriendButton.configure(title: "Go Friend")
        presentTestButton.configure(title: "Go Present")
        pushTestButton.configure(title: "Go Push")
        
        // 버튼에 인터페이스빌더 액션 연결
        goFriendButton.addTarget(self, action: #selector(goFriendButtonClicked), for: .touchUpInside)
        // target: 누굴 클릭했을 때 일어나는 일? 나 자신에 대해 일어나는 일 -> 100% self
        // action: 버튼을 눌렀을 때의 액션 #selector(함수명)
            // 함수 호출 연산자 ()를 사용해 호출하지 않고 왜 이름만 사용할까? (나중에)
                // #selector(goFriendButtonClicked()) 이렇게 실행을 해버리면,
                // viewDidLoad코드에서 화면이 뜨기 전의 시점에 실행이 되다가
            // 여기서 실행하면 뷰디드로드 시점에 먼저 실행되버림
        // for: UIController가 가지고 있는 이벤트, 이 버튼에 이 이벤트를 주겠다
        
        presentTestButton.addTarget(self, action: #selector(presentTestButtonClicked), for: .touchUpInside)
        // 버튼을 touchUpInside로 이벤트를 발생시킨 시점에 presentTestButtonClicked가 실행된다
    }
    
//    @IBAction // 스토리보드에서 가져온 것 이라는 뜻
    // addTarget은 Swift 등장 전 Objective-C때의 코드이기 때문에 그때의 규칙이 남아있다
    @objc  // @: Swift Attributes
    func goFriendButtonClicked() {
        print(#function)
//        // 테이블뷰
//        //1. 어떤 스토리보드에
//        let storyboard = UIStoryboard(name: "Friend", bundle: nil)
//        //2. 어떤 뷰컨트롤러를
//        let vc = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
//        //3. 어떤 방식으로 전환할지
//        present(vc, animated: true)
//        
//        // 컬렉션뷰
//        let storyboard = UIStoryboard(name: "Friend", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "FriendCollectionViewController") as! FriendCollectionViewController
//        present(vc, animated: true)
                let storyboard = UIStoryboard(name: "Friend", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
        
        // vc.을 통해서 무수히 많이 접근할 수 있는데 누군가 사용할 수도 있으니까 그런 문제를 미연에 방지 -> 쓸일이없는지 생각해보고 막아두기
//        vc.list
        
                present(vc, animated: true)
    }
    
    @objc
    func presentTestButtonClicked() {
        print(#function)
        //1. 어떤 스토리보드에 (같은 스토리보드여서 생략)
            // 같은 스토리보드 안에서 화면 전환하는 상황이라면, 스토리보드를 특정하지 않아도 된다
            // 다른 스토리보드로 전환할 때는 명세해줘야 한다
        //2. 어떤 뷰컨트롤러를
            // storyboard가 nil일 수 있기 때문에 옵셔널
            // self.storyboard: 내가 속해있는 스토리보드는 Main
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        
        /*
        // 버튼 클릭해서 화면이 띄워지면서 사용자 눈에 보이기 전의 시점에 랜덤보여줬다면 (정상)
        // 버튼 클릭했을 때 랜덤 레이블을 만들고 화면 전환 (테스트)
            // 이 코드가 실행될 시점에 아웃렛이 다 만들어져 있어야 문제가 없을 텐데,
            // 아웃렛은 스토리보드와도 결합을 해야해서 생각보다 늦은 시점에 만들어진다
            // 레이블이 온전하지 못한 상태
            // 아웃렛이 없는데 어떻게 글자를 넣어줄 수 있겠어 (아웃렛이 없는 nil상태)
            // nil상태가 아닌 다음 화면에서 기능이 실행되어야 한다
        // 화면 전환을 할 때 아웃렛을 가지고 오지는 않도록 개발을 하지 말자
            // 아웃렛을 만드는 시점을 당길 수 는 없다
        vc.nameLabel.text = "닉네임: \(Int.random(in: 1...100))"
        */
        //Pass Data 2. contents라는 다음 화면의 공간에 내용을 넣어주기
        vc.contents = "닉네임: \(Int.random(in: 1...100))"
        
        
        //3. 어떤 방식으로 전환할지
        present(vc, animated: true)
    }
}
