//
//  JackDetailViewController.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/14/25.
//

import UIKit

class Hello {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    // 상속이 없기 때문에 아래와 init 구문이 다름
}

final class JackDetailViewController: UIViewController {
    
    var nickname = "고래밥"
    
    func introduce() {
        print("안녕하세요 저는 \(nickname)입니다")
    }
    
    // test, nickname 생성 시점이 같으니까 lazy
    // 클로저니까 self 써줘야함
    // 메모리에서 내려가지 않는 누수가 발생하고 있는 코드
        // 누수는 lazy, closure, print, 함수 선언/호출 분리 때문이 아닌 self 키워드 때문 (self.nickname을 쓰지 않으면 Deinit잘 나타남)
        // self를 잘 써줘야함, 그동안 메모리누수가 엄청나게 일어나는 코드를 짠 것임
    lazy var test = { [weak self] in
        guard let self else { return }
        print("안녕하세요 저는 \(self.nickname)입니다")
    }
    // 누수 생기고 안생기고 분석할 바에는 습관적으로 문제가 생기지 않도록 해결 (너무 많은 곳을 탐구해야함)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        print("JackDetailViewController ViewDidLoad")
        print(nickname)
        /**
         DVC가 차지하는 공간도 있고, nickname이 차지하는 약간의 공간도 있다
         
         JackViewController Init
         JackViewController ViewDidLoad
         JackDetailViewController Init
         JackDetailViewController ViewDidLoad
         고래밥
         JackDetailViewController Init
         JackDetailViewController Deinit
         JackDetailViewController ViewDidLoad
         고래밥
         
         DVC가 온전히 공간을 잘 띄우기 위해서는 nickname저장 공간도 필요하고, 모든 프로퍼티가 준비되면 DVC를 띄워줄 준비도 필요함
         - DVC를 다 써서 사라질 때, nickname도 필요없어지기 때문에 둘 다 사라짐
         - DVC에 nickname, age, CV, TV 등의 프로퍼티, 메서드 공간을 차지하는데 Pop일 때 세세히 다 사라져야 DVC도 온전히 사라지도록 Deinit이 호출됨
         - 고래밥 공간도 잘 사라졌기 때문에 Deinit이 호출됨
         - 공간을 차지하고 잘 없어지기 위해서는 DVC가 가지고 있는 세세한 공간도 다 소거되어야 하는구나
         - Deinit만 잘 출력되면 메모리누수가 생길 위험은 생기지 않는다
         */
        
//        introduce()
        /**
         JackViewController Init
         JackViewController ViewDidLoad
         JackDetailViewController Init
         JackDetailViewController ViewDidLoad
         고래밥
         안녕하세요 저는 고래밥입니다
         JackDetailViewController Init
         JackDetailViewController Deinit
         JackDetailViewController ViewDidLoad
         고래밥
         안녕하세요 저는 고래밥입니다
         
         - 함수의 사용도 끝났기 때문에 nickname, introduce() 잘 사라져서 Deinit호출
         */
        
        test()  // 함수 선언, 실행 분리
        /**
         JackViewController Init
         JackViewController ViewDidLoad
         JackDetailViewController Init
         JackDetailViewController ViewDidLoad
         고래밥
         안녕하세요 저는 고래밥입니다
         JackDetailViewController Init
         JackDetailViewController ViewDidLoad
         고래밥
         안녕하세요 저는 고래밥입니다
         
         - 공간이 잘 사라졌다는 Deinit 신호를 볼 수 없음
         - 사용자의 눈에는 별 차이 없음, 개발자도 세세히 보지 않는 이상 잘 모르는 영역
         - 왔다갔다할 때마다 화면은 잘 사라졌다 나타나지만, Deinit은 호출되지 않음
         - 이는 공간이 새롭게 생겨야 하는데, 처음에 띄운 DVC공간이 남아있고, 온전히 메모리 공간에서 지워주지 못함, 새롭게 푸시하면 다시 새로운 DVC가 생김 -> 100번 푸시하면 100개의 DVC가 생김, 사용하지 않는데 99개의 공간을 차지하고 있음
         - 이들을 메모리상에서 누수가 생겼다고 한다: 다시 부를 수도 없고 다시 쓸 수도 없는데, 메모리에서 차지하고 있는 공간이 사라지지 않고 있다
         - 메모리에서 잘 사라졌는지, 문제가 있는지, 확인할 수 있는 방법은 init, Deinit 체크
         */
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // UIViewController 상속받고있기 때문에 부모클래스 이닛 호출
            // error: Must call a designated initializer of the superclass 'UIViewController'
            // 비어있는 Init()은 부모입장에서 코드베이스인지 스토리보드 기반인지 모르기 때문에 nibName을 nil 설정해줘야 한다
        
        print("JackDetailViewController Init")
        // 메모리 공간을 차지하는 것 확인
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  // 애플에 의해 어쩔 수 없이 만들어지는 구문
    
    deinit {
        print("JackDetailViewController Deinit")
        // 필요없어졌을 때 메모리 공간에서 잘 해제되는지
    }}
