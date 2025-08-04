//
//  EditViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    // Closure 방식
//    var space: String?  // 1. 데이터를 전달받을 공간 생성
//    var space: (() -> Void)?  // 단순히 String이 아닌 함수를 전달받고 싶다
        // 함수 전체 옵셔널: (() -> String)?
    var space: ((String) -> Void)?
    
    // Delegate 방식
//    var jack: Int?  // 공간 생성
//    var jack: ((Int) -> Void)?
//    var jack: TransitionViewController?  // 트렌지션컨트롤러에서 함수 하나 필요한데 뷰컨을 통으로 전달시켜봄
    // 필요한 것만 넘길 수 없을까?
    var jack: DataPassProtocol?
     
    private let textField1 = UITextField()
    private let textField2 = UITextField()
    private let textField3 = UITextField()
     
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        // 한 개의 데이터를 보냈지만 두 군데에서 데이터를 받는 것도 가능
//        textField1.text = space  // 이전 화면에서 전달받은 데이터 화면에 표시
//        textField2.text = space
        
//        textField1.text = "숫자 \(jack ?? 0)을 입력했습니다."  // 이전 화면에서 전달받은 데이터 표시
        
        idTest()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        setupTextField(textField1, placeholder: "Delegate 데이터")
        setupTextField(textField2, placeholder: "Closure 데이터")
        setupTextField(textField3, placeholder: "Notification 데이터")
         
//        setupButton(button1, title: "Delegate", color: .systemBlue)
//        setupButton(button2, title: "Closure", color: .systemGreen)
//        setupButton(button3, title: "Notification", color: .systemOrange)
        button1.configuration = UIButton.Configuration.jackStyle(title: "Delegate")
        button2.configuration = UIButton.Configuration.jackStyle(title: "Closure")
        button3.configuration = UIButton.Configuration.jackStyle(title: "Notification")
         
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setupButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupConstraints() {
        // 첫 번째 텍스트필드
        textField1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 첫 번째 버튼
        button1.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 텍스트필드
        textField2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 버튼
        button2.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 텍스트필드
        textField3.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 버튼
        button3.snp.makeConstraints { make in
            make.top.equalTo(textField3.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
    }
    
    @objc private func button1Tapped() {
        print("Delegate 버튼 눌림")
//        jack?(Int.random(in: 1...100))  // 랜덤숫자를 매개변수로 보내서 코드 실행
        
//        let random = Int.random(in: 1...100)
//        jack?.getRandomNumber(a: random)  // jack: TransitionViewController? (클로저에 비해서 직관적) 앞 화면 전체를 갖고 있는 상태에서 getRandomNumber실행
//        TransitionViewController().getRandomNumber(a: Int.random(in: 1...100))  // 셋 다 모두 같은 기능처럼 보이는데, 위와 다를바 없어보이는데 이거는 왜 제대로 동작하지 않을까? (버튼에 숫자가 표시되지 않음)
        
        jack?.getRandomNumer(num: Int.random(in: 1...100))  // 여전히 과한걸 넘긴건 맞지만 다른 거는 사용할 수 없다? 접근이 안되기 때문에 제약할 수 있다는 장점을 가지게 된다
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func button2Tapped() {
        print("Closure 버튼 눌림")
//        space?()  // 원하는 실행 시점에 실행: space에 내용이 있으면 (실행)
        space?(textField2.text!)  // 전달하고 싶은 name에 들어갈 내용
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func button3Tapped() {
        print("Notification 버튼 눌림")
        
        // 텍스트필드에 작성된 글자를 앞에 버튼으로 넘기고 싶음
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TextEdited"),  // 이 이름을 가진 형태로 신호를 보내겠다
                                        object: nil,  // 사용 거의 안함
                                        userInfo: ["nickname": "jack",
                                                   "text": textField3.text!
        ])  // 데이터 전달 구간: Dictionary?
        // NotificationCenter: wifi와 유사
        // default: Singleton과 유사
        // post: 데이터 전달한다
        
        navigationController?.popViewController(animated: true)
    }
}
