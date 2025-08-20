//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: BaseViewController {
    private let usernameLabel = CustomLabel(text: "Username", color: .black)
    private let usernameTextField = CustomTextField()
    private let usernameValidLabel = CustomLabel(text: "", color: .red)
    
    private let passwordLabel = CustomLabel(text: "Password", color: .black)
    private let passwordTextField = CustomTextField()
    private let passwordValidLabel = CustomLabel(text: "", color: .red)
    
    private let doSomethingButton = {
        let button = UIButton()
        button.setTitle("Do something", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField, usernameValidLabel, passwordLabel, passwordTextField, passwordValidLabel, doSomethingButton])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rx()
    }
    
    private func rx() {
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        //MARK: - .share
        // share를 하지 않지 않으면 usernameValid가 계속 생성됨 (여러 군데에서 구독할 때, 리소스 아끼려고 사용)
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)

    }
    
    override func configureHierarchy() {
        view.addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        usernameValidLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        passwordLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        
        passwordValidLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        
        doSomethingButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
