//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
    // Disposable 프로토콜에 직접 리소스 정리해달라는 dispose()정의되어있고,
    // disposables = [Disposable]()에서 묶어놨다가 deinit시점에 반복문을 돌면서 정리
   
    let passwordTextField = SignTextField(placeholderText: "")
    let nextButton = PointButton(title: "")
    
    private let passwordPlaceholder = Observable.just("비밀번호를 작성해주세요")
    private let nextButtonTitle = Observable.just("다음")
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        aboutDispose()
    }
    
    deinit {
        print("PasswordViewController Deinit")  // 모든 것들이 deinit돼야 출력됨
    }
    
    func bind() {
        /**
         1. subscribe > next error complete dispose print
         2. 순환참조 subscribe(with:)
         3. 호출되지 않는 이벤트 생략
         4. subscribe를 bind로 바꿔줘도 괜찮겠다 (받을 수 있는 이벤트 next만 - UI관련): 이벤트를 받지 못하는 bind로 변경
         5. Rx 특성과 연결
         */
        // passwordPlaceholder가 String이벤트를 전달하는 옵저버블
        // 클로저문 안에는 rx기반 코드는 들어갈 수 없음
        /*
        passwordPlaceholder
            .subscribe(with: self) { owner, value in
            owner.passwordTextField.placeholder = value
        } onError: { owner, error in  // 호출되지 않을 이벤트 생략 가능
            print("onError", error)
        } onCompleted: { owner in
            print("onCompleted")
        } onDisposed: { owner in  // 이벤트 종류가 아님
            print("onDisposed")
        }
        .disposed(by: disposeBag)
        */
        // rx스럽게: to 내부에는 rx기반 코드만 들어갈 수 있음
        passwordPlaceholder
            .bind(to: passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        nextButtonTitle
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        /*
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        @objc func nextButtonClicked() {
            navigationController?.pushViewController(PhoneViewController(), animated: true)
        }
         */
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func aboutDispose() {  // 리소스 정리. 정리하지 않으면 메모리 누수
        /**
         iOS GCD 쓰레드 관리 <-> Rx 스케쥴러 개념(쓰레드를 관리하는 것을 랩핑한 게 Scheduler)
         DispatchQueue.global.async > 네트워크 통신 > 백그라운드 쓰레드
         DispatchQueue.main.async > UI 업데이트, 시점 미루기 > 메인 쓰레드 (MainScheduler와 비슷함)
         */
        
        var bag = DisposeBag()
        
        // 옵저버블 만듦: 얼마마다 한번씩 이벤트를 보낼 수 있는 형태
        // interval을 만들 때 어떤 타입으로 방출할지 먼저 명시
        let test = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)  // 1초마다 숫자를 보내서 이벤트가 어떻게 정의되는지?
        let result = test  // UI변경 아니니까 subscribe
            .subscribe(with: self) { owner, value in
                print("onNext", value)
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: bag)
//            .dispose()  // 즉시 정리
//            .disposed(by: disposeBag)
        // error, completed 발생할 일 없으니까 이벤트를 계속 방출해서 계속 이벤트를 출력하고 있다 onNext 1,onNext 2,onNext 3, ...
        // 끝이 있으면 디스포즈될 수 있음
        // Infinite Observable
        // next 이벤트가 무한 방출되고 있어서 dispose되지 않음
            // 다음 버튼 눌러서 다른 뷰컨이 뜨고 현재 뷰컨이 보이지 않아도 아직 살아있음 (정리 안됨, 누수)
        //  화면 전환이 되더라도 리소스가 정리가 안되면 무한대로 실행 >> OK
        // dispose 메서드를 통해서 수동으로 일일이 정리
        // 옵저버블이 10 20 30 더라도 수동으로 일일이 정리
            // 매번 30개의 옵저버블을 개별적으로 정리하는 건 어려우니까
            // bag 인스턴스에 담아뒀다가 인스턴스를 새롭게 교체하는 형태로 리소스를 정리
        // 보통은 화면이 사라지거나 뷰컨트롤러 deinit이 될때라도 dispose
        
        // 무한대로 방출되는 infinite observable이 수백개라면?
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 지금으로부터 5초 뒤 코드 실행
//            result.dispose()  // 리소스 정리 (더이상 옵저버블이 동작하지 않도록 구독을 끊어주는 역할, 메모리 누수 X, 더 이상 동작하지 않도록)
//        }
        
        let test2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)  // 1초마다 숫자를 보내서 이벤트가 어떻게 정의되는지?
        let result2 = test2  // UI변경 아니니까 subscribe
            .subscribe(with: self) { owner, value in
                print("result2 onNext", value)
            } onError: { owner, error in
                print("result2 onError", error)
            } onCompleted: { owner in
                print("result2 onCompleted")
            } onDisposed: { owner in
                print("result2 onDisposed")
            }
            .disposed(by: disposeBag)
        
        // 수동으로 그 상수를 찾아서 직접 해제시켜줘야 함
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // 지금으로부터 5초 뒤 코드 실행
//            result2.dispose()
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // 지금으로부터 5초 뒤 코드 실행
            self.disposeBag = DisposeBag()  // 새로운 인스턴스로 교체되니까 bag이 물고 있는 옵저버블이 다 날아감, 기존의 bag이 날아가면서 Dispose됨 (여러개 수동으로 관리하기 어려우니까)
            // dispose()
        }
        
        
        
        // Finite Observable
        // Observable Lifecycle: next 이벤트 방출이 끝나면, complete 이벤트가 실행되고, dispose를 통해서 Sequence(Observable Sequence, Stream)를 종료시킴. 리소스 정리된 상태
        let array = Observable.from([1, 2, 3, 4, 5])
        array
            .subscribe(with: self) { owner, value in
                print("array onNext", value)
            } onError: { owner, error in
                print("array onError", error)
            } onCompleted: { owner in
                print("array onCompleted")
            } onDisposed: { owner in
                print("array onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
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
