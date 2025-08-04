//
//  TransitionViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

// 타입으로서의 프로토콜 활용
protocol Mentor { }
struct Den: Mentor { }
class Finn: Mentor { }
class Jack: Mentor { }

protocol DataPassProtocol {
    func getRandomNumer(num: Int)
}

/*
// 애플이 만들어 놓은 UIButton이 있었다면
class UIButton {
    // 여기에 setTitle 등의 메서드가 개별적으로 존재했다면,
    func setTitle() { }
    func setTitleColor() { }
    
    // configuration이라는 구조체가 UIButton 안에 정의되어 있다
    struct Configuration {
        // 이를 사용할 수 있는 최소버전이 iOS15
    }
}*/

// Mobile 부모 클래스를 상속받은 Google, Apple
class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Google: Mobile { }

class Apple: Mobile {
    let wwdc = "wwdc25"
}

// 굳이 Mobile을 만들 필요가 있을까?
// tableView.dequeuerReusalbleCell  // 무조건 부모 타입을 따라옴

class TransitionViewController: UIViewController {
    
    var a: Mentor = Jack()
    
    private let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        a = Finn()  // 같은 클래스이기는 하지만 타입 자체가 다르기 때문에 들어갈 수 없음 -> 같은 프로토콜을 채택한다면 들어갈 수 있음
        
        setupUI()
        setupConstraints()
        
        // 뒤 화면에서 쏜 신호 받기
            // 메서드를 따라가면 이해 가능 (코드가 직관적)
        // 1:N으로 데이터 전달 가능
            // 다른 VC에 같은 notiname으로 addObserver를 만들면 신호를 받을 수 있음
        NotificationCenter.default.addObserver(self,  // 누가 받아서 누가 처리하는지
                                               selector: #selector(notificationReceived),
                                               name: NSNotification.Name(rawValue: "TextEdited"),  // 같은 이름으로 신호를 받음 (주파수를 맞추는 것과 유사)
                                               object: nil)  // 보내는 입장에서 nil이기 때문에 받는 입장도 nil
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        idTest()
        
        test()
    }
    
    @objc func notificationReceived(notification: NSNotification) {  // 보낸 데이터를 매개변수로 받음
        print(#function)
        
        // let a = [3: "안녕"]
        // a[3]  // 안녕
        // 키 6이 존재하지 않는데 해당 키를 가져와라고 잘못 쓸 수 있기 때문에 거의 Dictionary는 옵셔널
        print(notification.userInfo?["nickname"])  // userInfo 안에 Dictionary로 내용을 숨겨놓음 (키 없으면 어떡해?)
        print(notification.userInfo?["text"])
        print(notification.userInfo?["jack"])
        
//        let text = notification.userInfo?["text"]  // text: Any? (String으로 전달했는데 Any?로 받음, 무슨 타입이든 받을 수 있게 만들어져 있어서 보내는 것도 String으로 지정한 것이 아니라 우연찮게 String으로 넣은 것임)
        if let text = notification.userInfo?["text"] as? String {  // userInfo에 "text"가 있다면, 그 값이 String에 해당하면 String타입으로 넣어달라
            centerButton.setTitle(text, for: .normal)
        }
    }
    
    private func setupUI() {
        view.addSubview(centerButton)
        view.backgroundColor = .white
         
        // iOS15 이전에 활용한 Default Style의 버튼 코드
        centerButton.setTitle("중앙 버튼", for: .normal)
        centerButton.setTitleColor(.white, for: .normal)
        centerButton.backgroundColor = .purple
        centerButton.layer.cornerRadius = 8
        
        // iOS15+ UIButton Configuration
        
        // UIButton.Configuration.filled() 스타일의 속성을 바꿔서 적용
        // ()가 아닌 .으로 접근하는 이유: Configuration구조체를 찾는 방법이 UIButton부터 차근차근 들어가는 방법밖에 없다
        // 버튼 안에 Configuration구조체가 있는데, 그 구조체에 Default로 만들어 놓은 다양한 속성들이 있다
            // static func filled() -> UIButton.Configuration: filled는 static func로 구성되어 있고 UIButton.Configuration형태로 반환
        // 구조체 안에 들어있는 내용을 바꿀 거라서 var로 설정한 것이다
            // class는 let으로 선언해도 내부의 내용을 바꿀 수 있지만 구조체는 전체를 변수로 설정
        /*var config = UIButton.Configuration.filled()  // 기본 속성 담기
        
        config.title = "중앙 버튼"
        config.subtitle = "여기가 버튼입니다"
        config.image = UIImage(systemName: "star")
        // titlePadding, imagePadding 등으로 간격 조절도 가능
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white  // 컬러는 열거형으로 되어있지 않다 (앞에 M)
        config.cornerStyle = .capsule  // .이라고 다 같은 열거형이 아니라, 앞에 K라고 나오는 것이 열거형의 각각의 케이스를 가져오는 것이다
        
        // 구조체의 속성을 변경한 다음
        // 버튼에 .configuration프로퍼티: UIButton의 Configuration구조체를 가져오겠다
            // 설명에 appearance키워드 사용: iOS15부터 appearance특성, 구조체특성을 많이 활용
        centerButton.configuration = config*/
        centerButton.configuration = UIButton.Configuration.jackStyle(title: "중앙 버튼")
         
        centerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // SnapKit을 사용하여 버튼을 화면 정중앙에 배치
        centerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    
    // Closure 방식
    @objc private func buttonTapped() {
        let vc = EditViewController()
        
        // B화면의 받는 형태에 맞게 전달
//        vc.space = "안녕하세요 저는 고래밥입니다"  // 내용을 넣어서 다음 화면에 전달 (화면: A->B)
//        vc.space = test  // 실행하지 않고 함수의 기능만 실어보냄
//        let 타입확인 = test  // 담아서 타입 확인
        
        // 재사용 하지 않고 여기서만 사용한다면, 이름없는 함수로 사용 가능 {매개변수 in}
        vc.space = { name in
            print("안녕하세요 저는 고래밥입니다")
            self.centerButton.setTitle(name, for: .normal)
        }
        
        // Delegate 방식 설명
//        vc.jack = Int.random(in: 1...100)  // 값전달(화면: A->B)
//        vc.jack = getRandomNumber  // 함수 기능을 jack이 갖게 하고
        vc.jack = self  // 나 자체를 jack한테 넘기고 -> B화면은 A화면 전부를 가지고 있음 -> 그 중에서 getRandomNumber를 실행시키겠다 (클로저보다 직관적일 수 있음)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func test(name: String) {
//        print("안녕하세요 저는 고래밥입니다")
//        centerButton.setTitle(name, for: .normal)
//    }
    
    // 다음화면에서 보낸 값을 매개변수로 받음 (화면: B->A)
//    func getRandomNumber(a: Int) {  // (Int) -> Void
//        let a = Int.random(in: 1...100)
//        self.centerButton.setTitle("숫자 \(a)", for: .normal)
//    }
    
    @objc func rightButtonTapped() {
        let vc = NextViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 타입캐스팅
    func test() {
        let array1 = [1, 2, 3, 4, 5]  // [Int]로 타입추론되어있기 때문에 가능
        let result = array1[0] + array1[1]
        print(result)
        
//        let array2 = [1, 2, true, "고래밥"]  // 무슨 타입일지 모를 땐 타입추론해보면 알 수 있음
        let array: [Any] = [1, 2, true, "고래밥"]
        
        // 지금은 0번 인덱스가 Int여서 연산이 가능하지만, append, remove, insert 등을 통해서 0, 1인덱스에 Int가 안들어갈 수도 있고
        // 애초에 [Any]로 지정되어 있기 때문에 Int타입이 아니기 때문(a: Any)에 연산 불가능
        let a = array[0]
//        let result = array[0] + array[1]
        // Any일 때 타입캐스팅을 통해 연산이 가능하도록 만들 수 있음
            // array의 0번 인덱스를 Any타입인건 아는데, Any타입이 Int로 떨어질 수 있는 환경인지 물어봄
            // 된다면 first에 이 내용이 들어올 거라서 Int로 바뀐다
        // Any일 때 다른 타입으로 캐스팅을 하는 작업들을 해주면 문제없이 연산 가능한 환경으로 만들 수 있다
        if let first = array[0] as? Int, let second = array[1] as? Int {
            print(first + second)
        }
        print(result)
        
        let mobile = Mobile(name: "모바일")
        let google: Mobile = Google(name: "구글")  // 내부에 아무것도 없지만 부모클래스에 대한 init해결해줘야함
        let apple: Mobile = Apple(name: "애플")
        // 부모타입으로 구성하면 name을 호출할 수 있음,
        mobile.name
        google.name
        apple.name
//        apple.wwdc   // 애플만 갖고 있는 wwdc를 호출할 수 없다 - Mobile타입으로, Mobile이라는 부모클래스에 들어있는 것이 아님 -> 그러면 이때는 어떻게 가져오지?
            // 부모클래스를 자식클래스로 다운캐스팅 - 그래야 자식클래스만의 메서드 등을 꺼내 사용할 수 있다
        if let value = apple as? Apple {
            // 문제 없다면 변경되기 때문에
            value.wwdc
        }
//        let g = apple as! Google  // 100% 실패 > 런타임이슈
            // 그동안 오류: 다운캐스팅하면서 강제로 꺼냈기 때문
    }
}

// Delegate 방식
extension TransitionViewController: DataPassProtocol {
    // 함수를 쓰도록 강제화
    func getRandomNumer(num: Int) {
        self.centerButton.setTitle("숫자 \(a)", for: .normal)
    }
}
