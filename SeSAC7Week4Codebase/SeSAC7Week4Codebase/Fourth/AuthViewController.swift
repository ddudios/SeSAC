//
//  AuthViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import SnapKit

//extension UITextField {  // 여기저기에서 사용되는게 아니니까 굳이 모든 텍스트필드가 이 함수를 설정할 수 있으니까 쓸 준비를 하는건 아니다
//    func setUI() {
//        self.borderStyle = .none
//    }
//}

/*
class Jack {
    let name = a()  // 둘 다 인스턴스가 만들어진 다음에 쓸 수 있는데 어떻게 안만들어졌는데 쓸 수 있냐
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func a() -> Int {  // 인스턴스 메서드: 인스턴스가 생성이 되고 난 다음에 호출이 가능
        return 10
    }
}*/

class AuthViewController: UIViewController {
    
    // 인스턴스 프로퍼티
    //1. 타입메서드로 활용했을 때 공간이 영영 남아있는 이슈
    //2. 각 뷰 객체마다 메서드 수가 늘어나는 이슈, 이 메서드는 재활용도 안된다
        // 이름 짓기도 귀찮고 -> 이름까지 지어줄 필요 없지 않나
        // 익명 함수 / 클로저 / 즉시 실행 함수
//    let emailTextField = setEmailTextField()
    let emailTextField = {  // 함수가 실행된 결과가 담김
        /*
        print("emailTextField 익명함수")
        let emailTextField = UITextField()
        emailTextField.placeholder = "이메일을 작성해주세요"
        emailTextField.keyboardType = .emailAddress
//        emailTextField.setUI()
        emailTextField.font = .boldSystemFont(ofSize: 15)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.backgroundColor = .white
        emailTextField.tintColor = .systemPurple*/
        let emailTextField = PurpleTextField(placeholder: "이메일을 작성해 주세요", keyboard: .emailAddress)
        return emailTextField
    }()  // 이 함수 실행할게 - 실행 결과를 emailTextField에 담는다
//    let passTextField = setPasswordTextField()
//    let ageTextField = UITextField()

    let passTextField = {
//        let emailTextField = UITextField()
        /*
        let emailTextField = PurpleTextField()
        emailTextField.placeholder = "비밀번호를 작성해주세요"
        emailTextField.keyboardType = .default
        emailTextField.isSecureTextEntry = true
//        emailTextField.borderStyle = .none
//        emailTextField.font = .boldSystemFont(ofSize: 15)
//        emailTextField.layer.borderWidth = 1
//        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
//        emailTextField.layer.cornerRadius = 8
//        emailTextField.backgroundColor = .white
//        emailTextField.tintColor = .systemPurple*/
        let emailTextField = PurpleTextField(placeholder: "비밀번호를 작성해주세요", keyboard: .default)
        return emailTextField
    }()
    
    // lazy는 var밖에 사용하 수 없다
    // 옵셔널처럼 처음에 nil값이 들어왔다가 바뀌는 형태
        // 따라서 let은 사용할 수 없다
    lazy var ageTextField = {
        print(#function)
        //        let emailTextField = UITextField()
        /*
        let emailTextField = PurpleTextField()
        emailTextField.placeholder = "나이를 선택해주세요"
        emailTextField.keyboardType = .numberPad
        //        emailTextField.borderStyle = .none
        //        emailTextField.font = .boldSystemFont(ofSize: 15)
        //        emailTextField.layer.borderWidth = 1
        //        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
        //        emailTextField.layer.cornerRadius = 8
        //        emailTextField.backgroundColor = .white
        //        emailTextField.tintColor = .systemPurple
        
        emailTextField.inputView = picker // 키보드 영역에 키보드 대신 다른 것을 넣을 수 있음 (뷰의 성격을 띈 누구라도 다 들어갈 수 있음 - 테이블뷰도 가능)*/
        let emailTextField = PurpleTextField(placeholder: "나이를 선택해주세요", keyboard: .numberPad)
        emailTextField.inputView = picker
        return emailTextField
    }()
        

    
//    let a = Jack(name: "J", age: 22)  // 인스턴스 메서드가 만들어진 후에야 인스턴스 메서드, 프로퍼티에 접근할 수 있는데 인스턴스를 만들어야 하는 시점에 메서드를 가져다가 쓰려고하니까 애초에 안만들어진 것을 어떻게 가져다 쓰냐
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 시작")
        configureHierarchy()
        configureLayout()
        configureView()
        print("viewDidLoad 끝")
        
//        ageTextField.inputView = picker
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        // 원래 모두 연결시켜줘야 프로토콜이 가지고 있는 메서드를 모두 사용할 수 있는데
        // 하나의 텍스트필드에만 기능을 사용하고 싶다면 하나의 텍스트필드에만 델리게이트를 연결하면 부하직원의 분기처리는 하지 않아도된다
        passTextField.delegate = self
        emailTextField.delegate = self
    }
    
    // 휠이 멈추면 값이 달라짐
    @objc func datePickerValueChanged() {
        print(#function)
        ageTextField.text = "\(picker.date)"
    }
}

//MARK: UI 속성 정의
extension AuthViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(emailTextField)
        view.addSubview(passTextField)
        view.addSubview(ageTextField)
    }
    
    func configureLayout() {
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        passTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        ageTextField.placeholder = "dfasdf"
        print(#function)
    }
    
    /*
    // 인스턴스 메서드 -> 타입메서드로 만들면 어느 시점에서나 사용할 수 있으니까 에러를 해결할 수 있다
    // 함수를 묶는 이유는 여러 곳에서 재사용해주려는데 이름을 지어줄 가치도 없다
    // 이름을 붙이지 않고 반환값이 TextField인지 알고 있기 때문에
    static func setEmailTextField() -> UITextField {
        let emailTextField = UITextField()
        emailTextField.placeholder = "이메일을 작성해주세요"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .none
        emailTextField.font = .boldSystemFont(ofSize: 15)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.backgroundColor = .white
        emailTextField.tintColor = .systemPurple
        return emailTextField  // 속성이 적용된 emailTextField를 반환해서 꺼내줌
    }
    
    static func setPasswordTextField() -> UITextField {
        print(#function)
        let emailTextField = UITextField()
        emailTextField.placeholder = "비밀번호를 작성해주세요"
        emailTextField.keyboardType = .default
        emailTextField.isSecureTextEntry = true
        emailTextField.borderStyle = .none
        emailTextField.font = .boldSystemFont(ofSize: 15)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.backgroundColor = .white
        emailTextField.tintColor = .systemPurple
        return emailTextField
    }
    
    static func setAgeTextField() -> UITextField {
        print(#function)
        let emailTextField = UITextField()
        emailTextField.placeholder = "나이를 선택해주세요"
        emailTextField.keyboardType = .numberPad
        emailTextField.borderStyle = .none
        emailTextField.font = .boldSystemFont(ofSize: 15)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemPurple.cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.backgroundColor = .white
        emailTextField.tintColor = .systemPurple
        return emailTextField
    }*/
}

// UITextFieldDelegate프로토콜이 여러가지 기능을 가지고 있다
// 3개의 텍스트필드라고 같은 부하직원을 3명을 부를 수 없다 -> 조건처리로 나눠서 사용해야한다
extension AuthViewController: UITextFieldDelegate {
    // 다 써서 다 프린트해보고 이게 이때 실행되는구나
    
    // didEndOnExit Action 대신
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passTextField {
            print(#function)
            view.endEditing(true)
            return true
        } else {
            return false
        }
    }
}
