//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    let photoImageView = UIImageView()
    
    let disposeBag = DisposeBag()
    
    let color = Observable.just(UIColor.yellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        // color 이벤트 발생시 -> bind 실행
        color
        // bind는 내부 코드를 보면 subscribe을 해주고 있음 + weak self
            .bind(with: self) { owner, color in
                // Rx적인 코드는 아님
                owner.view.backgroundColor = color
                owner.emailTextField.textColor = color
            }
            .disposed(by: disposeBag)
        */
        // 받아온 컬러를 그대로 뷰에 보여줄 수 있냐 + self 해결하지 않아도 됨
        // to 내부에는 swift적인 코드인 view.backgroundColor는 들어갈 수 없음
        // Rx적인 코드로 랩핑해줘야 함
        color
            .bind(to: view.rx.backgroundColor, /*emailTextField.rx.textColor*/)  // 가변매개변수로 구성되어 있음
            .disposed(by: disposeBag)
        
        // 4자리 이상 이메일 작성 시, 로그인 버튼 회색 > 검정색
        // textField addTarget editChanged
        /*
        // .rx: rx로 바꾼다 -> rx스럽게 text를 랩핑해서 받아옴: ControlProperty<String?> -> 전달 이벤트 String?
        emailTextField.rx.text
            .bind(with: self) { owner, value in
                print("bind \(value)")
                guard let value else { return }
                if value.count >= 4 {
                    owner.signInButton.backgroundColor = .black
                } else {
                    owner.signInButton.backgroundColor = .lightGray
                }
            }
            .disposed(by: disposeBag)
        /**
         bind Optional("")
         -> 글자가 입력될 때마다 bind Optional("")
         */
         */
        /*
        emailTextField  // 각각 .마다 stream이 바뀌고 있음
            .rx
            .text
            .orEmpty  // 옵셔널 해제해서 텍스트 가져옴
            .bind(with: self) { owner, value in
                if value.count >= 4 {
                    owner.signInButton.backgroundColor = .black
                } else {
                    owner.signInButton.backgroundColor = .lightGray
                }
            }
            .disposed(by: disposeBag)
         */
        /*
        /*let a = */emailTextField  // stream: SignTextField
            .rx  //  : Reactive<SignTextField>
            .text  // ControlProperty<String?>
            .orEmpty  // ControlProperty<String>  // 여기까지 map의 클로저로 들어온다
            .map{ $0.count >= 4 }  // Observable<Bool>  // ({ text in text.count >= 4 })오토클로저 특성으로 ()생략 가능 -> { text in text.count >= 4 } -> $0.count >= 4
            .bind(with: self) { owner, value in  // 결국 판단에 대해서는 Bool
                owner.signInButton.backgroundColor = value ? .black : .lightGray
            }  // any Disposable
            .disposed(by: disposeBag)  // ()
         */
        
        emailTextField.rx.text.orEmpty
            .map { $0.count >= 4 }
            .bind(to: signInButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func signInButtonClicked() {
        PhotoManager.shared.getRandomPhoto(api: .random) { photo in
            print("random", photo)
//            self.photoImageView.kf.setImage(with: URL(string: photo.urls.regular))
        }
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
        photoImageView.backgroundColor = .blue
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(photoImageView)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
    }
    

}
