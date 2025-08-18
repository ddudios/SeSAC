//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()  // 디스포즈 라는게 있구나 이게 뭘까?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        //MARK: - 12:40
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)  // Rx = touchUpInside
        // tap 안에 touchUpInside가 들어있음, 이마저도 스트림
        //let a =
        nextButton  // 원래는 UIButton
            .rx  // Observable
            .tap  //
            .map { "안녕하세요" }  // 버튼을 클릭했을 때 데이터의 흐름을 바꿈 (String으로 바꿈)
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)
        // 다음 버튼 클릭 (addTarget) -> 문자열로 바꿔서 텍스트 필드에 보여줘라 (emailTextField.text = "안녕하세요)
        // nextButton.rx.tap         .map { "안녕하세요" }.bind(to: emailTextField.rx.text).disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
        print(#function)
    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
