//
//  ViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/21/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var height: NSLayoutConstraint!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let user = User()
        // init기능이 안쓰더라도 호출해서 자동으로 사용할 수 있음, 여기서 이니셜라이저 구문을 실행해서 인스턴스 생성
//        let mentor = Mentor()
        let mentor = Mentor(name: <#T##String#>, age: <#T##Int#>)*/
        
        
        goButton.addTarget(self, action: #selector(goButtonClicked), for: .touchUpInside)
        
        // Function Type Preview: 어떤 매개변수, 어떤 반환값을 갖는 지에 따라 다양한 타입이 나올 수 있다
            // 함수 실행시 goButtonClicked() 함수 호출 - 함수 호출 연산자()
            // selector는 함수의 이름만 쓰면서, 함수의 이름과 실행을 별개로 가져가려고 한다
            // Type: var nick = "고래밥" //String Type
                    // var a = 30 // Int Type
            // 함수를 실행하지 않고 함수 기능만 넣어준 것
        
        let a = jack
        print(a)  // 함수 호출 연산자를 활용해 실행하면 String타입
                    // 함수의 기능과 실행을 별개로 나누어서 처리하는 것도 가능하다 (Swift)
        a()
        
        let b = jack()  // 함수를 실행하고 난 결과를 담아서 String 타입
        let c: () -> String = jack  // 함수를 실행하지 않고 함수 내용만 담은 상태
        
        // 함수 타입이 같다면 바꿔치기도 가능
        var e = jack
        e = den
        
        // 다 담을 때 오류가 나지 않았는데 이건 오류
            // 같은 함수 이름이 여러개
            // 둘 중에 뭘 담아야할 지 모름 -> 타입 어노테이션으로 명시해 인지할 수 있게 만든다
        let f: () -> Int = finn
            // 또는 아무것도 넣지 않은 채로 함수명명
        let g = finn(a:)
        
//        JackImage(systemImage: <#T##String#>)
    }
    
    // 매개변수는 없고 반환값은 String을 반환하는 함수
    // 실행하고 무언가를 던져주는 반환값이 있는데 어디에도 안 쓸거야?
    func jack() -> String {
        print("=")
        return "안녕하세요"
    }
    
    // 함수를 실행하고 나면 끝
    @objc func goButtonClicked() {
        // 화면 전환: 스토리보드에 ResultViewController가 있다면 present
        // 스토리보드에 더이상 ResultViewController가 없어서 오류
//        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        let vc = ResultViewController()
        // 클래스 다룰 때도 인스턴스를 만들 때 인스턴스 생성을 위해서 ()를 만들었는데, ResultViewController도 클래스이기 때문에 인스턴스로 공간을 만들어서 전환할 것이기 때문에 가져오는 방식이 이름만 ViewController이지 사실상 같은 맥락
        // vc의 타입과 vc2의 타입이 같음: ResultViewController
        // 만약 스토리보드가 있다면 오류: 씬, 로직 연결, 아웃렛도 가져와야하는데 그것들을 안가져오기 때문에 앱이 터짐
        
        present(vc, animated: true)
        
        // ()는 실행시점과 비슷하게 볼 수 있는데
            // goBUttonClicked() 함수 호출 연산자 - 괄호의 유무 차이는 함수의 실행을 도와줌
            // ResultViewController() 메서드의 일종이기는 한데, init이 숨어있다
            // 함수를 호출해주는 연산자가 있고 인스턴스를 생성해주는 연산자가 있고 이게 init구문이구나
    }
    
    // #selector - 이름만 적더라도 찾을 수 있던 이유
    // 코드를 쓰다보면 함수 이름이 겹칠 수 있다 -> 구별할 수단이 없으니까 오류
    // 함수 타입이 다르기 때문에 문제가 생김 -> 펑션타입이 메서드 하나면 특정할 수 있음
    // 못찾으니까 같은 이름 쓰지 말기, Function Type에 대한 의미
//    func goButtonClicked() {
//        
//    }
    
    func finn() -> Int {  // Function Type: () -> Int
        return 10
    }
    
    func finn(a: Int) -> Int {  // Function Type: (Int) -> Int
        return a * 2
    }
    
    func den() -> String {  // Function Type: () -> String
        return "저는 Den입니다"
    }
    
    let d = den
    // 함수를 실행하지 않고 이름만 담아보면 어떤 형태로 정의되어 있는지 확인할 수 있음
}

// 클래스 안에 아무것도 들어있지 않아도 활용(Empty())가능
class Empty {
    
}

class User {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct Mentor {
    let name: String
    let age: Int
    
    // 눈에 보이지 않지만 자동으로 생성해줘서 초기화를 해주는 init() 기능이 있음
        // init()을 써야 활용(Mentor())할 수 있는 것이 아니라 init을 안써도 호출해서 사용할 수 있고 이때의 ()는 인스턴스를 만든다는 init(){}기능이 숨어있다
        // class/struct 호출하고 ()를 활용하는 것은 initializer구문을 실행하는 것이다
    
    // initializer구문을 안써도 자동으로 만들어주지만
    // 나이만 따로 받고 이름은 고래밥으로 받아야지
    // 초기화는 개발자 마음대로 가능
    init(age: Int) {
        self.name = "고래밥"
        self.age = age
    }
    
    init() {
        self.name = "손님"
        self.age = 13
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // Mentor구조체가 초기화되기 위해서는 가지고있는 모든 프로퍼티가 초기화되어야 하고
    // 모든 프로퍼티들이 초기화되기 위해서 3가지 방법을 지원해주고 있는 것
}

//class JackImage {
//    var image: String  // 이미지를 로드할 수 있는 공간
//    
//    init(image: String) {
//        self.image = image
//    }
//    
//    init(systemImage: String) {
//        
//    }
//    
//    init(asdf: String) {
//        
//    }
//}
