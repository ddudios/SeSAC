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
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    @objc private func textFieldDidChange() {
        print(#function)
        guard let id = idTextField.text, let pw = passwordTextField.text else {
            validationLabel.text = "nil입니다"
            loginButton.isEnabled = false
            return
        }
        
        if id.count >= 4 && pw.count >= 4 {
            validationLabel.text = "잘 했어요"
            loginButton.isEnabled = true
        } else {
            validationLabel.text = "아이디, 비밀번호 4자리 이상입니다."
            loginButton.isEnabled = false
        }
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
