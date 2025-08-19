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
    
    // 그동안의 Observable이 아닌 Rx의 Observable (내부구조가 그렇게 다르지는 않은데 어쨌든 이름만 같음)
    // just방식으로 String 일을 벌림
    // '중복확인'이라는 글자만 전달하면 할 일은 끝 (끝이 있는 이벤트)
    let buttonTitle = Observable.just("중복확인")
    
    let disposeBag = DisposeBag()  // 디스포즈 라는게 있구나 이게 뭘까?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
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
        
        
        // buttonTitle은 just형태로 일을 벌리고 있음 -> 수습
        buttonTitle  // observable이자 이벤트 전달
            .subscribe { value in  // next: 보통은 잘 된 케이스에 해당한다
                print("onNext - \(value)")  // print대신 화면 전환/얼럿 등으로 대체될 수 있다, 이렇게 수습하겠다를 subscribe으로 연결
                self.validationButton.setTitle(value, for: .normal)  // validationButton에 setTitle로 value값을 보내줌
            } onError: { error in
                print("onError - \(error)")
            } onCompleted: {  // 작업이 끝났다는 이벤트 -> 할 일을 다 했기 때문에 메모리 공간에서 내려가는 것처럼 리소스 정리
                print("onCompleted")
            } onDisposed: {  // 이벤트는 아님, 리소스 정리가 잘 됐는지 확인 (출력되지 않으면 메모리 누수)
                print("onDisposed")
            }
        // 다 썼으면 리소스 정리 (더 이상 메모리에 불필요하게 남아있을 필요는 없으니까)
            .disposed(by: disposeBag)  // Compile warning: subscribe 사용시 -> disposed 반환값을 써줘야 함
  // 구독한다(모두 옵셔널로 정의된 것을 opt로 다 가져와서 사용해보고 소거해보기) 이벤트 전달에 따라 onNext의 타입이 바뀜, 모든 것들이 클로저임 -> 메모리 누수 나기가 쉬움
        /**
         # 어떻게 수습할래의 옵션이 많은 것
         onNext - 중복확인  #이벤트를 받음
         onCompleted
         onDisposed
        */
        
        // 항상 with 있는것 self -> weak self (RC늘리지 않음)
        buttonTitle
            .subscribe(with: self) { owner, value in
                print("onNext - \(value)")
                owner.validationButton.setTitle(value, for: .normal)
            }
            .disposed(by: disposeBag)

        
        /*
        // infinite Observable, ui error가 발생할 일은 없다X compltedX(끝나지 않음)
         // Next이벤트만 출력을 해 둔 이유: 어쩌피 Completed/Error는 발생할 일이 없는 무한한 친구니까 생략
        nextButton.rx.tap
            .subscribe { _ in
                print("button onNext")
            } onDisposed: {
                print("button onDisposed")
            }
            .disposed(by: disposeBag)

        // 무한한 시퀀스, 중간에 멈추면 안됨, 사용자가 몇번 클릭하던 계속 클릭해줘야 함, 지속적으로 next만 출력됨
        nextButton.rx.tap  // 여기까지가 이벤트를 발생시키고 일을 벌리는 Observable (버튼 클릭 행위로 일을 벌림)
        // 이벤트를 어떻게 수습하지? -> subscribe 작성
            .subscribe { _ in  // 전달된 tap은 Generic의 <Void> 타입 (전달되는 매개변수가 없다)
                // next, error, complete 이벤트 3개 다 처리할 수 있지만, 발생하지 않으니까 생략을 한 경우
                
                print("button onNext")  // 다음 버튼을 누를 때마다 "onNext" 출력됨
            } onError: { error in
                print("button onError")
            } onCompleted: {
                print("button onCompleted")
            } onDisposed: {
                print("button onDisposed")
            }
            .disposed(by: disposeBag)
         */
        // .subscribe이 없으면 일을 계속 벌리고는 있는데, 일을 수습해줄 수는 없다(아무 일도 일어나지 않는다)
            // ex.클릭은 되지만 레이블에 내용을 표시하지는 못한다
        
        /**
         # 버튼은 에러, 컴플릿 이벤트 발생하지 않고 next이벤트 다음 바로 disposed
         onNext - 중복확인
         onCompleted
         onDisposed
         button onNext
         button onNext
         button onNext
         button onDisposed
         */
        
        basicObservableTest()
        
        /**
         #.subscribe Vs. bind
         - bind는 subscribe과 똑같은데 onNext이벤트만 있음
         - onDisposed도 리소스 정리가 잘 됐는지, 메모리 누수가 발생하지 않았는지 확인하기 위해서만 존재 -> 확인됐으면 지우고 사용하면 됨
         - subscribe은 next, completed, error 다 처리할 수 있음 / bind는 next 이벤트만 처리할 수 있음
         - subscribe은 next, completed, error 다 처리할 수 있는데 어차피 tap에서 발생시킬 수 있는게 next밖에 없으니까 생략해서 안 쓰는 거라면,
         - bind는 애초에 next를 제외한 나머지 이벤트를 못받음
         - subscribe은 일부로 안한거고, bind는 애초에 이벤트를 못받음
         */
        
//        nextButton.rx.tap
//            .bind { [weak self] _ in  // 애초에 next 이벤트밖에 처리를 못하는 구조
//                guard let self = self else { return }
//                print("button bind onNext")  // next, error, complete 이벤트 3개 다 처리할 수 있지만, 발생하지 않으니까 생략을 한 경우
//                let vc = PasswordViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            .disposed(by: disposeBag)
//        // 혹시 모를 메모리 누수 방지 1.
        
        nextButton.rx.tap
            .withUnretained(self)
            .bind { [weak self] _ in  // 애초에 next 이벤트밖에 처리를 못하는 구조
                guard let self = self else { return }
                print("button bind onNext")
                let vc = PasswordViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        // 혹시 모를 메모리 누수 방지 2.
            // Rx는 전부 클로저 구문인데 weak self 수백번쓰는게 맞나?
        
            // withUnretained작성하는 순간에 내부에 self는 다른 코드를 써야 한다
            // .withUnretained(self)에서 self를 해결해도 해결된 self를 쓰는 게 아니라 다시 강한 self를 쓰게되다 보니까 코드적으로 문제가 생김
            // weak self 안 쓰는 대신에 .withUnretained(self)를 써야함 - 이것 마저도 줄이고 싶음
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                print("button bind onNext")
                let vc = PasswordViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        // 혹시 모를 메모리 누수 방지 3.
        /**
         bind(with: onNext: ) 같은 기능을 하는 구독인데 매개변수가 하나 추가됨 - self에 대해서 weak self로 만들어주고 RC를 늘리지 않아서 메모리 누수를 해결해주는 요소라서 요즘엔 이걸 더 많이 사용함
         - with: 순환참조를 해결하고 싶은 요소 작성
         - 클로저의 매개변수 AnyObject: 옵셔널을 해결해서 담고 싶은 요소 owner
         - weak에 대해서 RC를 해결하고 옵셔널을 해결해서 담은 self라는 네이밍 대신에 owner라는 네이밍을 사용
         - 그러니까 withUnretained를 사용하지 않고도 with를 활용하면 메모리 누수가 발생할 수 있는 self를 해결
         - next이벤트를 전달받을 때, 매개변수는 늘지만 연산자를 사용하지 않아도 되는 점, weak self를 사용하지 않아도 되는 점에 있어서 이 형태를 가장 많이 사용
         - self에 대한 문제가 해결된 게 owner이기 때문에, 메모리 누수를 해결하지 않은 self를 사용하면 여전히 메모리 누수 발생중이기 때문에 self 대신에 클로저의 매개변수로 받은 owner 사용
         - 1, 2, 3 모두 사용 가능, 이렇게 발전해왔다
         - bind(with:)를 안쓰면 Rx모르고 쓴다고 생각 -> 습관화
         */
    }
    
    func basicObservableTest() {
        let list = ["고래밥", "칙촉", "카스타드", "갈배"]
        Observable.just(list)  // just 방식으로 방출
        
        // 배열을 가져왔기 때문에 배열을 받음
            .subscribe { value in
                print("just \(value)")
            } onError: { error in
                print("just \(error)")
            } onCompleted: {
                print("just onCompleted")
            } onDisposed: {
                print("just onDisposed")
            }
            .disposed(by: disposeBag)
        
        Observable.from(list)
            .subscribe { value in
                print("from \(value)")
            } onError: { error in
                print("from \(error)")
            } onCompleted: {
                print("from onCompleted")
            } onDisposed: {
                print("from onDisposed")
            }
            .disposed(by: disposeBag)
        /**
         # 유한한 Observable - just: Next이벤트를 통해서 처음에 이벤트가 전달이 되면 배열을 통으로 주니까 just에 남아있는 데이터는 더이상 존재하지 않는다(유한한 이벤트) 유한한 이벤트이기 때문에 모든게 끝나서 더이상 전달해줄 게 없는게 확실하니까 Completed 출력 -> Completed가 출력되고 나면 할거 다 했으니까 리소스 정리가 되고 리소스 정리가 되었으니까 그 시점에 Disposed Vs. from: Next이벤트 4번 전달(반복문을 도는 느낌) 각각의 Element를 개별적으로 방출하고 갈배가 마지막 Element였기 때문에 거기까지 오면 onCompleted로 끝났구나를 알고 Disposed 실행
         just ["고래밥", "칙촉", "카스타드", "갈배"]
         just onCompleted
         just onDisposed
         from 고래밥
         from 칙촉
         from 카스타드
         from 갈배
         from onCompleted
         from onDisposed
         */
        
        // 무한한 Observable: list를 무한히 반복해라는 방식으로 전달하면
        Observable.repeatElement(list)  // next이벤트로 무한히 방출
            .take(10)  // 몇개까지 받고 싶은지 갯수 제한 (사용예시: 몇개까지만 테이블뷰에 보여주고 싶어)
            .subscribe { value in
                print("repeatElement \(value)")
            } onError: { error in
                print("repeatElement \(error)")
            } onCompleted: {
                print("repeatElement onCompleted")  // 10번 방출 이후 끝난 것을 앎
            } onDisposed: {
                print("repeatElement onDisposed")  // 끝난 것을 아니까 호출
            }
            .disposed(by: disposeBag)  // 리소스 정리 + 구독 취소
    }
    
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
        print(#function)
    }

    func configure() {  // 버튼 UI
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
