//
//  PhoneViewController2.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/21/25.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController2: UIViewController {
   
    let disposeBag = DisposeBag()
    
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let text = BehaviorSubject(value: "고래밥")
    let viewModel = PhoneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }
    
    func bind() {
        let input = PhoneViewModel.Input(buttonTap: nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        // subject 텍스트필드에 글자 출력
        output.text
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
