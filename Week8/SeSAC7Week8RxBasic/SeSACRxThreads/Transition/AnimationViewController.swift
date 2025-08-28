//
//  AnimationViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/28/25.
//

import UIKit
import SnapKit

class AnimationViewController: UIViewController {
    private let logoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star.circle.fill")
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemYellow
            return imageView
        }()
        
        private let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "이메일"
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            return textField
        }()
        
        private let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "비밀번호"
            textField.isSecureTextEntry = true
            return textField
        }()
    
        private let loginButton = {
            let button = UIButton()
            button.setTitle("로그인 버튼", for: .normal)
            button.backgroundColor = .systemGreen
            return button
        }()

        private let signUpLabel: UILabel = {
            let label = UILabel()
            label.text = "계정이 없으신가요? 회원가입"
            label.textColor = .systemBlue
            label.backgroundColor = .white
            label.textAlignment = .center
            label.font = UIFont(name: "S-CoreDream-9Black", size: 30)
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setAnimations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc = FirstViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setAnimations() {
        // 모든 뷰는 UIView를 상속받고 있음
        logoImageView.alpha = 0  // 시작 상태
        logoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)  // 레이아웃을 아래에서 잡아놨기 때문에 레이아웃 자체가 0.1이 된것은 아님
        
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        loginButton.alpha = 0
        signUpLabel.alpha = 0
        // hidden은 중간값이 없음, Alpha는 0~1사이 값을 유연하게 가질 수 있으니까 사용
        
        animationEmailTextField()
        
        
        // delay: 위에서부터 순차적으로 등장하고 싶을 때 사용할 수 있음
        UIView.animate(
            
            withDuration: 1,  // 1초동안 거쳐서
            delay: 0,  // 몇 초 뒤 시작
//            options: [.repeat, .autoreverse], // 1초동안 반복 + 자동거꾸로
//            options: .curveEaseInOut,  // 10 -> 100 애니메이션 변화 정비례하게 / 가속도를 줘서 처음엔 빨리 진행되고 나머지는 천천히 등의 기능 (아래와 같이 사용 못함)
            usingSpringWithDamping: 0.5,  // 튀기는 느낌
            initialSpringVelocity: 0.5
            
        ) { /*[weak self] _ in*/
            // 메모리 누수가 많이 발생해서 weak self 처리해줘야 함
//            guard let self else { return }
            self.logoImageView.alpha = 1  // 끝 상태
            
//            self.logoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 500)
        }
    }
    
    private func animationEmailTextField() {
        UIView.animate(withDuration: 1, delay: 0.5) {
            self.emailTextField.alpha = 1  // 1초동안 이메일 텍스트 필드
        } completion: { _ in
            // completion: 하나의 애니메이션이 끝나면 다음 애니메이션이 실행되도록 할 수 있음
            self.animationPasswordTextField()
        }
    }
    
    private func animationPasswordTextField() {
        UIView.animate(withDuration: 0.3) {
            self.passwordTextField.alpha = 1
        } completion: { _ in
            self.animationLoginButton()
        }
    }
    
    private func animationLoginButton() {
        UIView.animate(withDuration: 0.3) {
            self.loginButton.alpha = 1
        } completion: { _ in
            self.animationSignUpLabel()
        }
    }
    
    private func animationSignUpLabel() {
        UIView.animate(withDuration: 0.3) {
            self.signUpLabel.alpha = 1
        } completion: { _ in
            print("애니메이션 끝")
            self.emailTextField.becomeFirstResponder()
        }
    }
    
    private func setupViews() {
            view.backgroundColor = .white
            
            // for in vs forEach
            [logoImageView, emailTextField, passwordTextField, loginButton, signUpLabel]
                .forEach { view.addSubview($0) }
            
            logoImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
                make.width.height.equalTo(100)
            }
            
            emailTextField.snp.makeConstraints { make in
                make.top.equalTo(logoImageView.snp.bottom).offset(50)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(emailTextField.snp.bottom).offset(20)
                make.left.right.height.equalTo(emailTextField)
            }
            
            loginButton.snp.makeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(30)
                make.left.right.equalTo(emailTextField)
                make.height.equalTo(44)
            }
            
            signUpLabel.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }
            
//            view.addSubview(animationImageView)
//            
//            animationImageView.snp.makeConstraints { make in
//                make.size.equalTo(100)
//                make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
//            }
        }
}
