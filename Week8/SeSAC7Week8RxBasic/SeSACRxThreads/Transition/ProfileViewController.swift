//
//  ProfileViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/27/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController {
    
    let passwordTextField = SignTextField(placeholderText: "")
    let nextButton = PointButton(title: "")
    
    let disposeBag = DisposeBag()
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        bind()
//        let a = nextButton.rx.tap
    }
    
    private func bind() {
//        let input = ProfileViewModel.Input(buttonTap: nextButton.rx.tap)
        // 어쩌피 버튼 클릭되는 것은 이벤트를 받아서 전달만 하면 되니까 Observable로 변경해서 사용, 옵저버블 객체로 변경
        let input = ProfileViewModel.Input(buttonTap: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.detail
//            .observe(on: MainScheduler.instance)
//            .bind(with: self) { owner, value in  // Main Thread 보장 X (bind to는 괜찮음)
        
        // 하나하나 신경쓰기 번거로우면, 항상 메인에서 동작을 보장하는 Drive객체 사용
//            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))  // 아무리 여기서 변경해줘도 아래 드라이브 만나면 메인에서 동작
//            .asDriver(onErrorJustReturn: "")
        
            .drive(with: self) { owner, value in
                print(value, Thread.isMainThread)  // 고래밥 false -> MainScheduler로 변경 -> 고래밥 true
                
//                let vc = ProfileDetailViewController()
//                vc.text = value
//                vc.viewModel.output.navTitle = value로 하고싶지만 불가넝~
//                vc.viewModel.text = value
                // private을 쓰면 다른 파일에서 데이터 전달 불가능
                
                // 꼭 안해도 되는데 뭐가 아쉬워서 하나? 굳이 text를 써야하나 외부에서 접근이 가능한데 등의 이유로 개선
                let viewModel = ProfileDetailViewModel(text: value)
//                vc.viewModel = viewModel
                let vc = ProfileDetailViewController(viewModel: viewModel)
                
                owner.navigationController?.pushViewController(vc, animated: true)
                
            }
            .disposed(by: disposeBag)
        
        output.placeholder
            .debug("placeholder")
            .bind(to: passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.buttonTitle
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
    }
}

extension ProfileViewController {
    func configureLayout() {
        view.backgroundColor = .white
        
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
