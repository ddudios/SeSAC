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
    let viewModel = SimpleValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
//        let a = usernameTextField.rx.text.orEmpty
//        let a = passwordTextField.rx.text.orEmpty
        let input = SimpleValidationViewModel.Input(username: usernameTextField.rx.text.orEmpty, password: passwordTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.usernameValidText
            .bind(to: usernameValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordValidText
            .bind(to: passwordValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.everythingValid
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
