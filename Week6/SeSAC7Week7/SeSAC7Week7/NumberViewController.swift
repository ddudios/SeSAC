//
//  NumberViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit

// 뷰생성, 레이아웃잡기, 뷰배치 뷰컨밖에못하기 때문에, 수정할 수 없는 부분은 존재
// 대신, 메서드가 호출될때마다 출력되고 있어서 글자가 달라질때마다 엄청난 기능이 수행되는데, 문자열에 대한 정보만 알고싶어
// 레이블에 작성된 내용들을 뷰모델에 전달만 해줄테니까 로직분리하는 코드는 너네가 알아서 하고 거기에 대한 결과로 컬러에 대한 여부, 문자열에 대한 여부만 내가 담당할게
// 글자수 체크, 범위 체크 등은 뷰모델이 해라 !

class NumberViewController: UIViewController {

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        
        viewModel.closureText = {
            self.formattedAmountLabel.text = self.viewModel.outputText
        }
        
        // Observable class Test
        let jack = Observable(text: "jack")  // text 값을 초기화해서 Observable 인스턴스를 만들었다
            // 처음 들어온 jack은 프린트되지 않음, 값이 변경된 것은 아니니까
//        jack.hello = {  // 함수 형태를 넣어보자
//            print("첫번째 헬로")
//        }
        /**
         인스턴스를 생성했을 때도 첫번째 클로저를 실행하려면?
         - hello가 nil일 때는 실행되지 않음
         - hello에서 didSet -> didSet이 호출되지 않을 수 있음 / init에서 동작
         - 필요한 시점에 VC에서 실행시켜주면 됨 jack.hello?()
         **/
//        jack.hello?()  // 첫번째 헬로
        // 이 구문을 빼먹을 수도 있으니까 이들을 쉽게 만들기 위해서 bind()
        jack.binde {
            print("bind: 첫번째 헬로")  // 이 기능을 실행과 동시에 이 기능을 hello에 넣어줌
                // 위에 각자 한것( jack.hello = {} + jack.hello?() )을 한꺼번에 한 것과 동일
        }  // bind: 첫번째 헬로
        
        jack.text = "finn"  // text 값이 바뀌었어요 jack finn
            // 값에 대한 변경을 인지해서 출력이 됨
//        jack.hello = {  // 함수 형태를 넣어보자
//            print("두번째 헬로")
//        }  // 첫번째 헬로
        // bind: 첫번째 헬로
        
        jack.text = "den"  // text 값이 바뀌었어요 finn den
//        jack.hello = {  // 함수 형태를 넣어보자
//            print("세번째 헬로")
//        }  // 두번째 헬로
        // bind: 첫번째 헬로
        
        /**
        세번째 헬로는 왜 실행되지 않지?
         - jack인스턴스 만드니까 init구문 출력
         - text == jack
         - hello = 첫번째
         
         - text == finn -> didSet
         - hello있다면 실행: 기존에 들어있던 첫번째 실행
         - hello = 두번째
         
         - text를 den으로 변경: didSet 실행
         - hello있다면 실행: 기존에 들어있던 두번째 실행
         - hello = 세번째
         
         실행해주려면 어떻게 해야할까?
         - 지금 hello == 세번째가 들어있지만, 내용이 변경되어야 didSet으로 실행되어 세번째가 출력될 수 있다
         **/
    }
 
    @objc private func amountChanged() {
        print(#function)
        // 텍스트필드에 입력된 글자를 VM로 전달
        viewModel.inputField = amountTextField.text  // 글자 전달
        
//        //1) 옵셔널
//        guard let text = amountTextField.text else {
//            formattedAmountLabel.text = ""
//            formattedAmountLabel.textColor = .red
//            return
//        }
//        
//        //2) Empty
//        if text.isEmpty {
//            formattedAmountLabel.text = "값을 입력해주세요"
//            formattedAmountLabel.textColor = .red
//            return
//        }
//        
//        //3) 숫자 여부
//        guard let num = Int(text) else {
//            formattedAmountLabel.text = "숫자만 입력해주세요"
//            formattedAmountLabel.textColor = .red
//            return
//        }
//        
//        //4) 0 - 1,000,000
//        if num > 0, num <= 1000000 {
//            
//            let format = NumberFormatter()
//            format.numberStyle = .decimal
//            let result = format.string(from: num as NSNumber)!
//            formattedAmountLabel.text = "₩" + result
//            formattedAmountLabel.textColor = .blue
//        } else {
//            formattedAmountLabel.text = "백만원 이하를 입력해주세요"
//            formattedAmountLabel.textColor = .red
//        }
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }

    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }

}
