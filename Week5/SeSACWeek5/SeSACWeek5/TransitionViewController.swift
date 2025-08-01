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
         
        centerButton.setTitle("중앙 버튼", for: .normal)
        centerButton.setTitleColor(.white, for: .normal)
        centerButton.backgroundColor = .purple
        centerButton.layer.cornerRadius = 8
         
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
}

// Delegate 방식
extension TransitionViewController: DataPassProtocol {
    // 함수를 쓰도록 강제화
    func getRandomNumer(num: Int) {
        self.centerButton.setTitle("숫자 \(a)", for: .normal)
    }
}
