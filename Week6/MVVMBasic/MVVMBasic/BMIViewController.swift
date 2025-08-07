//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BmiValidationError: Error {
    case emptyString
    case outOfRange
    case isNotDouble
}

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
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
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        guard let heightString = heightTextField.text else {
            return
        }
        
        guard let weightString = weightTextField.text else {
            return
        }
        
        do {
            let message = try validateUserInput(heightText: heightString, weightText: weightString)
            resultLabel.text = message
        } catch let error {
            switch error {
            case BmiValidationError.emptyString:
                showAlert(title: "키 또는 몸무게를 입력해 주세요")
            case BmiValidationError.isNotDouble:
                showAlert(title: "숫자로 입력해 주세요")
            case BmiValidationError.outOfRange:
                showAlert(title: "키는 50~300, 몸무게는 10~300 사이로 입력해주세요")
            default:
                print("error: \(error)")
            }
        }
    }
    
    private func validateUserInput(heightText: String, weightText: String) throws -> String {
        if heightText == "" {
            throw BmiValidationError.emptyString
        }
        
        if weightText == "" {
            throw BmiValidationError.emptyString
        }
        
        guard let height = Double(heightText) else {
            throw BmiValidationError.isNotDouble
        }
        
        guard let weight = Double(weightText) else {
            throw BmiValidationError.isNotDouble
        }
        
        if height < 50 || height > 300 {
            throw BmiValidationError.outOfRange
        }
        
        if weight < 10 || weight > 300 {
            throw BmiValidationError.outOfRange
        }
        
        return "올바른 입력: 키(\(height)), 몸무게(\(weight))"
    }
}

extension BMIViewController {
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "입력을 확인해 주세요", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
