//
//  SettingViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/8/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var titleDivider: UIView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameTextFieldDivider: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        self.title = "\(UserDefaults.standard.string(forKey: "nickname") ?? "대장")님 이름 설정하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainColor]
        self.navigationController?.navigationBar.barTintColor = .mainColor
        
        CustomUI.designDividerUI(titleDivider, opacity: 0.1)
        
        CustomUI.designTextFiledUI(nicknameTextField, placeholder: "닉네임을 입력해 주세요", textAlignment: .left)
        CustomUI.designDividerUI(nicknameTextFieldDivider)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let nickname = nicknameTextField.text else { return }
        
        if nickname.count < 2 || nickname.count > 6 {
            alert(title: nil, message: "대장 이름은 2글자 이상 6글자 이하까지 가능합니다.")
        } else if nickname.count >= 2 && nickname.count <= 6 {
            UserDefaults.standard.set(nickname, forKey: "nickname")
            alert(title: nil, message: "대장 이름이 변경되었습니다.")
        } else {
            print("error: \(#function) \(nickname.count)")
        }
    }
}

extension SettingViewController {
    func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
