//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum BirthValidationError: Error {
    case outOfRangeYear
    case outOfRangeMonth
    case outOfRangeDay
    case isNotInt
}

class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
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
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
        guard let yearString = yearTextField.text else {
            return
        }
        
        guard let monthString = monthTextField.text else {
            return
        }
        
        guard let dayString = dayTextField.text else {
            return
        }
        
        do {
            try birthValidateUserInput(yearString: yearString, monthString: monthString, dayString: dayString)
        } catch let error {
            switch error {
                
            case .outOfRangeYear:
                resultLabel.text = "입력 가능 범위: 1700 <= year <= 2025"
            case .outOfRangeMonth:
                resultLabel.text = "입력 가능 범위: 1 <= month <= 12"
            case .outOfRangeDay:
                resultLabel.text = "입력 가능 범위: 1 <= day <= 31"
            case .isNotInt:
                resultLabel.text = "입력 가능 타입: Int"
            }
        }
    }
    
    private func birthValidateUserInput(yearString: String, monthString: String, dayString: String) throws(BirthValidationError) {
        if let year = Int(yearString),
           let month = Int(monthString),
           let day = Int(dayString) {
            
            if year < 1700 || year > 2025 {
                throw BirthValidationError.outOfRangeYear
            } else if month < 1 || month > 12 {
                throw BirthValidationError.outOfRangeMonth
            } else if day < 1 || day > 31 {
                throw BirthValidationError.outOfRangeDay
            } else {
                resultLabel.text = "D + \(birthday(year: year, month: month, day: day))"
            }
        } else {
            resultLabel.text = "숫자를 입력해주세요"
        }
    }
    
    private func birthday(year: Int, month: Int, day: Int) -> Int {
        let birthComponents = DateComponents(year: year, month: month, day: day)
        let birthday = Calendar.current.date(from: birthComponents)!
        return Calendar.current.dateComponents([.day], from: birthday, to: Date()).day ?? 0
    }
}
