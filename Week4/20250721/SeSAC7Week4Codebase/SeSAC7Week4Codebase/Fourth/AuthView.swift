//
//  AuthView.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/28/25.
//

import UIKit
import SnapKit

// 베이스뷰는 유아이뷰를 상속받음
class AuthView: BaseView {
    let emailTextField = {
        let emailTextField = PurpleTextField(placeholder: "이메일을 작성해 주세요", keyboard: .emailAddress)
        print("pppppp")
        return emailTextField
    }()

    let passTextField = {
        let emailTextField = PurpleTextField(placeholder: "비밀번호를 작성해주세요", keyboard: .default)
        return emailTextField
    }()
    
    lazy var ageTextField = {
        let emailTextField = PurpleTextField(placeholder: "나이를 선택해주세요", keyboard: .numberPad)
        emailTextField.inputView = picker
        return emailTextField
    }()
    
    let picker = UIDatePicker()
    
    override func configureHierarchy() {
        addSubview(emailTextField)
        addSubview(passTextField)
        addSubview(ageTextField)
    }
    
    override func configureLayout() {
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        passTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        ageTextField.placeholder = "dfasdf"
        picker.preferredDatePickerStyle = .wheels
    }
}
