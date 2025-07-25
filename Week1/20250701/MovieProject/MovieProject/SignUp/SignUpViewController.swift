//
//  SignUpViewController.swift
//  MovieProject
//
//  Created by Suji Jang on 7/21/25.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let idTextField = UITextField()
    private let pwTextField = UITextField()
    private let nicknameTextField = UITextField()
    private let positionTextField = UITextField()
    private let codeTextField = UITextField()
    private let signUpButton = UIButton()
    private let additionalInfoButton = UIButton()
    private let toggleSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Auto Layout
    private func configureUI() {
        view.backgroundColor = .black
        
        addSubviewContainer()
        autoLayout()
        containerProperties()
    }
    
    private func addSubviewContainer() {
        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(pwTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(positionTextField)
        view.addSubview(codeTextField)
        view.addSubview(signUpButton)
        view.addSubview(additionalInfoButton)
        view.addSubview(toggleSwitch)
    }
    
    private func autoLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(200)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        positionTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(positionTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(48)
        }
        
        additionalInfoButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalTo(signUpButton.snp.leading)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.trailing.equalTo(signUpButton.snp.trailing)
        }
    }
    
    private func containerProperties() {
        titleLabel.text = "JACKFLIX"
        titleLabel.textColor = .main
        titleLabel.font = .largeTitle
        titleLabel.textAlignment = .center
        
        configureTextField(idTextField, placeholder: "이메일 주소 또는 전화번호")
        configureTextField(pwTextField, placeholder: "비밀번호")
        configureTextField(nicknameTextField, placeholder: "닉네임")
        configureTextField(positionTextField, placeholder: "위치")
        configureTextField(codeTextField, placeholder: "추천 코드 입력")
        
        configureButton(signUpButton, title: "회원가입")
        configureOptionButton(additionalInfoButton, title: "추가 정보 입력")
        
        toggleSwitch.isOn = true
        toggleSwitch.onTintColor = .main
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3, NSAttributedString.Key.font: UIFont.body])
        textField.textAlignment = .center
        textField.backgroundColor = .sub
        textField.tintColor = .white
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.textColor = .white
    }
    
    private func configureButton(_ button: UIButton, title: String) {
        let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.black])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
    }
    
    private func configureOptionButton(_ button: UIButton, title: String) {
        let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.systemGray3])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .clear
    }
}
