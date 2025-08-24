//
//  NicknameSettingViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameSettingViewController: BaseViewController {
    
    @IBOutlet private var titleDivider: UIView!
    @IBOutlet private var saveButton: UIBarButtonItem!
    
    @IBOutlet private var nicknameTextField: UITextField!
    @IBOutlet private var nicknameTextFieldDivider: UIView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = NicknameSettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        saveButton.rx.tap
            .asDriver(onErrorJustReturn: ())
            .drive(with: self) { owner, _ in
                guard let nickname = owner.nicknameTextField.text else { return }
                
                if nickname.count < 2 || nickname.count > 6 {
                    super.messageAlert(title: nil, message: "대장 이름은 2글자 이상 6글자 이하까지 가능합니다.")
                } else if nickname.count >= 2 && nickname.count <= 6 {
                    UserDefaultsManager.shared.nickname = nickname
                    super.popAlert(title: nil, message: "대장 이름이 변경되었습니다.") {
                        owner.navigationController?.popToRootViewController(animated: true)
                    }
                    owner.title = "\(nickname)님 이름 설정하기"
                } else {
                    print("error: \(#function) \(nickname.count)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        
        self.title = "\(UserDefaultsManager.shared.nickname)님 이름 설정하기"
        
        CustomUI.designDividerUI(titleDivider, opacity: 0.1)
        
        CustomUI.designTextFiledUI(nicknameTextField, placeholder: "닉네임을 입력해 주세요", textAlignment: .left)
        CustomUI.designDividerUI(nicknameTextFieldDivider)
    }
}
