//
//  SignUpViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit
import SnapKit 

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let signUpButton = PointButton(title: "회원가입")
      
    override func viewDidLoad() {
        super.viewDidLoad()
  
        configureLayout()
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
      
    @objc func signUpButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
     
    
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
