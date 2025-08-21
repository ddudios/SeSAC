//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let resultLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    let viewModel = SecondphoneViewModel()
    
    let limitNumber = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }

    func bind() {
        /* 흐름 이해
        // 버튼 클릭 > 레이블 내용
        nextButton.rx.tap
            .bind(with: self) { owner, _ in  // 스트림의 마지막 타입이 들어옴: 현재는 tap이니까 Void
                owner.resultLabel.text = "버튼 클릭"
            }
            .disposed(by: disposeBag)
        
        // 더 Rx활용
        nextButton.rx.tap
//            .map({ _ in  // 전달된 마지막 내용이 매개변수의 타입으로 들어옴
//                "버튼 클릭"
//            })  // (함수호출 연산자 안에 {함수}) - Auto Closure 덕분에 간단하게 소괄호를 생략해서 사용할 수 있다
            .map { "버튼 클릭" }  // stream: Void -> String
            .bind(with: self) { owner, value in  // owner는 그저 weak self? 아무거나들어오네.. self = VC인듯  // 받아온 마지막 value
                owner.resultLabel.text = value
            }
            .disposed(by: disposeBag)
        */
        /*
        nextButton.rx.tap
            .map { "버튼 클릭" }  // 텍스트필드 글자 가져와서 판단하는 로직까지 만들고 싶음
//            .debug("버튼1")
//            .debug("버튼2")
//            .debug("버튼3")  // 구독이 역으로 올라감
         .bind(with: self) { owner, value in
            owner.resultLabel.text = value
         }  // "버튼 클릭"이라는 글자가 원래는 Observer 안에 있었는데 받아온 내용을 그대로 뿌려주기만 하니까, 극단적으로 이 Observer에서는 무슨 내용이 어떤 방식으로 오는지는 신경안쓰고 그냥 온 값을 그대로 보여주겠다, 여기서 더 줄여나가면 받아온 내용을 그대로 보여주고 있기 때문에 bind to로 쓸 수 있다
            .bind(to: resultLabel.rx.text)  // 왜 weak self 과정이 없지?, value가 그냥 들어가네.. 클로저가 아니라 함수니까 캡쳐현상이 일어날 수 없으니까 강한참조사이클이 일어날 수 없음
         // 레이블에 이 String을 다이렉트로 연결시키겠다. 클로저문 내에서는 Rx코드를 쓸 수 없지만 bind(to:)를 이용해서는 Rx코드로 결합해볼 수 있기 때문에 버튼 클릭하면 문자열로 바꿔서 레이블에 바로 뿌려주겠다의 형태로 수정
            .disposed(by: disposeBag)
        */
        
//        let limitNumber = 8
        // 텍스트필드가 달라질 때마다 레이블에 내용 출력
// isposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .map { 7 }
//            .map { "\($0) 입니다"}
//            .map { <#String#> in  // 끝단 데이터에 따라 클로저의 매개변수가 달라진다
//                <#code#>
//            }
        phoneTextField.rx
            .text
            .orEmpty
            .withUnretained(self)  // self, value
            .map { owner, text in
                text.count >= owner.limitNumber
            }
            .bind(with: self) { owner, value in
                owner.resultLabel.text = value ? "통과" : "8자 이상을 입력해주세요"
            }
            .disposed(by: disposeBag)
         
        // 텍스트필드 글자 가져와서 판단하는 로직까지 만들고 싶음
        nextButton.rx.tap  // 여기까지는 타입이 Void ()
            .withLatestFrom(phoneTextField.rx.text.orEmpty)  // 다른 값 가져오고 싶을 때 사용 (가장 마지막 입력된 값을 가져옴)  // 타입이 더이상 String이 아닌 (AnyObject, String)
//            .bind(with: self, onNext: { owner, value in
//                print(value)
//            })
            .map { text in  // textField에 입력된 글자가 text로 전달됨
                text.count >= 8 ? "통과": "8자 이상 입력해주세요"
            }
            .bind(to: resultLabel.rx.text)  // 메서드니까 캡쳐 현상이 일어나지 않으니까 강한참조사이클이 일어날 수 없음
            .disposed(by: disposeBag)
        
        // 보내고 싶은 데이터 상수에 담아서 타입 확인하면 어떻게 넘길지 나옴
        let a = nextButton.rx.tap
        let b = phoneTextField.rx.text.orEmpty
        
        let input = SecondphoneViewModel.Input(buttonTap: nextButton.rx.tap, text: phoneTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        output.text
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        view.addSubview(resultLabel)
    
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
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nextButton.snp.bottom).offset(20)
        }
        
        resultLabel.text = "test"
    }

}
