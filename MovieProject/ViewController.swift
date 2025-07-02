//
//  ViewController.swift
//  MovieProject
//
//  Created by Suji Jang on 7/1/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var addInfoButton: UIButton!
    
    @IBOutlet var toggleSwitch: UISwitch!
    
    @IBOutlet var idValidationLabel: UILabel!
    @IBOutlet var pwValidationLabel: UILabel!
    @IBOutlet var nicknameValidationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        titleLabel.text = "JACKFLIX"
        titleLabel.textColor = .red
        titleLabel.font = .boldSystemFont(ofSize: 30)
        
        // 중복코드 줄여보기
        designTextFieldUI(textField: idTextField, placeholder: "이메일 주소 또는 전화번호")
        designTextFieldUI(textField: pwTextField, placeholder: "비밀번호")
        designTextFieldUI(textField: nicknameTextField, placeholder: "닉네임")
        designTextFieldUI(textField: placeTextField, placeholder: "위치")
        designTextFieldUI(textField: codeTextField, placeholder: "추천 코드 입력")
        
        designSignUpButtonUI()
        designAddInfoButtonUI()
        
        toggleSwitch.setOn(true, animated: true)
        toggleSwitch.onTintColor = .red
        toggleSwitch.thumbTintColor = .white
    }

    func designTextFieldUI(textField: UITextField, placeholder: String) {
        textField.backgroundColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 17)!])
        textField.textAlignment = .center
        textField.textColor = .white
        textField.tintColor = .white
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.frame.size.height = 42
        
        if textField == idTextField {
            textField.keyboardType = .emailAddress
        }
    }
    
    func designSignUpButtonUI() {
        signUpButton.backgroundColor = .white
        let title = NSAttributedString(string: "회원가입",
                                       attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                                                    NSAttributedString.Key.foregroundColor: UIColor.black])
        signUpButton.setAttributedTitle(title, for: .normal)
        signUpButton.layer.cornerRadius = 8
    }
    
    func designAddInfoButtonUI() {
        let title = NSAttributedString(string: "추가 정보 입력",
                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white])
        addInfoButton.setAttributedTitle(title, for: .normal)
    }
    
    func designValidationLabelUI(label: UILabel, text: String) {
        label.textColor = .red
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
    }
    
    @IBAction func idTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    @IBAction func idTextFieldEditingDidEnd(_ sender: UITextField) {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$|^01([0-9])([0-9]{3,4})([0-9]{4})$"
        
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let _ = regex?.firstMatch(in: idTextField.text ?? "", options: [], range: NSRange(location: 0, length: idTextField?.text?.count ?? 0)) {
            idValidationLabel.isHidden = true
        } else {
            idValidationLabel.isHidden = false
            designValidationLabelUI(label: idValidationLabel, text: "특수문자를 포함한 이메일 또는 특수문자를 제외한 전화번호를 정확히 입력해 주세요")
        }
    }
    
    @IBAction func pwTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    @IBAction func pwTextFieldEditingChanged(_ sender: UITextField) {
        guard let count = pwTextField?.text?.count else { return }
        if count < 4 {
            pwValidationLabel.isHidden = false
            designValidationLabelUI(label: pwValidationLabel, text: "4자 이상 입력해 주세요")
        } else {
            pwValidationLabel.isHidden = true
        }
    }
    
    @IBAction func nicknameTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    @IBAction func nicknameTextFieldEditingDidEnd(_ sender: UITextField) {
        nicknameValidationLabel.isHidden = false
        if nicknameTextField.text == "" {
            designValidationLabelUI(label: nicknameValidationLabel, text: "글자를 입력해 주세요")
        } else {
            nicknameValidationLabel.isHidden = true
        }
    }
    
    @IBAction func placeTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    @IBAction func codeTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if idValidationLabel.isHidden && pwValidationLabel.isHidden && nicknameValidationLabel.isHidden {
            print(idTextField.text, pwTextField.text, nicknameTextField.text, placeTextField.text, codeTextField.text)
        } else {
            print("이메일 또는 전화번호, 비밀번호, 닉네임을 모두 입력해 주세요")
        }
    }
}

