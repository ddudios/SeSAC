//
//  LoginViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
 
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    private let validationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
       
    // 12.
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
        
        // 레이블에 내용 보여지게 만듦
//        viewModel.outputValidationLabel.playAction {
//            self.validationLabel.text = self.viewModel.outputValidationLabel.text
//        }
        // 31. 호출과 내부가 같은 프로퍼티를 사용중
        viewModel.outputValidationLabel.playAction { value in
            self.validationLabel.text = value
        }
        
        viewModel.outputTextColor.playAction { color in
            self.validationLabel.textColor = color ? .blue : .red
        }
    }
    
    @objc private func textFieldDidChange() {
        print(#function)
//        guard let id = idTextField.text, let pw = passwordTextField.text else {
//            validationLabel.text = "nil입니다"
//            loginButton.isEnabled = false
//            return
//        }
//        
//        if id.count >= 4 && pw.count >= 4 {
//            validationLabel.text = "잘 했어요"
//            loginButton.isEnabled = true
//        } else {
//            validationLabel.text = "아이디, 비밀번호 4자리 이상입니다."
//            loginButton.isEnabled = false
//        }
        
        // 10. 목표: 아이디 텍스트필드 바뀔때마다 didChange -> ViewModel에 전달: 유효성 검사
        // 13.
        viewModel.inputIdTextField.value = idTextField.text!
        // 왜 텍스트로 전달해야하는지? String을 Field로 랩핑했으니까 Field클래스로 전달되고 그 내부의 text에 넣어줘야 함 -> Field클래스의 text가 달라지니까 그 text의 didSet이 실행됨: (text값이 변경됨) textFieldDidChange() text didSet 12 123
    }

    @objc private func loginButtonTapped() {
        print(#function)
    }

    
}

extension LoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(validationLabel)
        view.addSubview(loginButton)
    }

    private func configureConstraints() {
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(idTextField)
        }

        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(idTextField)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.left.right.equalTo(idTextField)
            make.height.equalTo(50)
        }
    }

    private func configureActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

}
