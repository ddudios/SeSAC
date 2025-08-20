//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "")
    let nextButton = PointButton(title: "")
    
    private let disposeBag = DisposeBag()
    
    // Observable
    private let placehoder = Observable.just("닉네임 입력")
    private let buttonTitle = Observable.just("닉네임 추천")
    private let text = BehaviorSubject(value: "고래밥")  // 이벤트를 받을 수 있는 형태로 변경: Observable + Observer
    //Observable.just("고래밥")
    // 왜 subject로 써야 하는지, 왜 = 아니라 onNext로 데이터를 보내는지
    /**
     #Subject (subject/bind, onNext/error/completed 가능)
     Observable + Observer --전달-->
     text(고래밥) -> 텍스트 필드 글자 반영
     버튼 클릭 -> 칙촉으로 고래밥 변경 -> 그것을 텍스트필드 글자에 표시
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }
    
    func bind() {
        // Observer
        placehoder
            // bind로 연결
            .bind(to: nicknameTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        buttonTitle
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        text
            .bind(to: nicknameTextField.rx.text)
//            .bind(with: self, onNext: { owner, value in
//                owner.nicknameTextField.text = value
//            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                let list = ["칙촉", "갈배", "몽쉘"]
                let random = list.randomElement()!
//                owner.nicknameTextField.text = random
                
//                owner.text = random
                // rx는 무조건 next, complete, error (등호 사용 불가능)
                owner.text.onNext(random)  // 처음에는 =와 onNext가 같다고 생각해도 된다
                
            }.disposed(by: disposeBag)
    }
    /**
     random > text > nicknameTextField.rx.text 연동
     */

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
