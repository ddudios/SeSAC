//
//  SignInViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit
import Alamofire
import SnapKit
 
class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = PointButton(title: "회원이 아니신가요?")
      
    override func viewDidLoad() {
        super.viewDidLoad()
  
        configureLayout()
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func signInButtonClicked() { 
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
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
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
         
    }
}
