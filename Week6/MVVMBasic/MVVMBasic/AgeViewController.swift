//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum AgeValidationError: Error {
    case outOfRange
    case isNotInt
}

final class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func resultButtonTapped() {
        view.endEditing(true)
        
        guard let text = textField.text else {
            print("텍스트필드 글자: nil")
            return
        }
        
        do {
            let result = try validateUserInput(text: text)
            label.text = result
        } catch let error {
            switch error {
            case AgeValidationError.isNotInt:
                label.text = "숫자만 기입 가능합니다"
            case AgeValidationError.outOfRange:
                label.text = "1~100세만 기입 가능합니다"
            default:
                print(#function, error)
            }
        }
    }
    
    private func validateUserInput(text: String) throws -> String {
        guard let age = Int(text) else {
            throw AgeValidationError.isNotInt
        }
        
        print(age)
        
        if age < 1 || age > 100 {
            throw AgeValidationError.outOfRange
        }
        
        return "올바른 나이 입력: \(age)"
    }
}
