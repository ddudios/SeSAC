//
//  NumberRemindController.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/11/25.
//

import UIKit

class NumberRemindController: UIViewController {
    
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
    
    let viewModel = NumberViewModelRemind()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        
        let sesac = Field("새싹")  // Field Init
        // 1. 값이 변경된건 아니기 때문에 didSet은 출력되지 않음
        
//        sesac.text = "안녕하세요"  // text didSet 새싹 안녕하세요
        // 1-1. 값이 변경되고 나서야 didSet 호출됨
        
        print("===")
        
//        sesac.action = {
//            print("액션에 기능을 넣어주기")
//            self.view.backgroundColor = .yellow
            // 2-1. 굳이 왜 클로저를 만드는거지?
            // - view.backgroundColor = .yellow와 같은 구문은 Field 클래스 안에서 할 수 없기 때문에 외부에서 넣어줌
            
            // 2-2. 프린트도, 배경색 변경도 되지 않음
            // - 텍스트가 변경되기 전에는 action에 아무것도 없으니까(nil) 실행시킬 수 없음
            // - action에 기능이 들어가만 있는 상태
            // - action의 실행시점은 값이 바뀌어야 됨 (didSet)
//        }
        
        // 3. action을 실행시켜주고 싶다
        // 3-1. (방법1) action을 실행시켜주기 위해서 text의 값을 변경시킴
//        sesac.text = "값이 바뀌어야 이전에 들어갔던 액션이 실행됨"
        /**
         Field Init
         text didSet 새싹 안녕하세요
         text didSet 안녕하세요 값이 바뀌어야 이전에 들어갔던 액션이 실행됨
         액션에 기능을 넣어주기
         */
        
        // 3-2. (방법2) action을 실행시켜주기 위해서 액션을 의도적으로 실행시킴
//        sesac.action?()
        
        print("===")
        
        // 4-1. 매개변수 action에 {함수}가 들어감
//        sesac.playAction {  // sesac.action = { 위의 프로퍼티에 기능 넣은것과 같은 역할
//            print("액션에 기능을 넣어주기")
//            self.view.backgroundColor = .green
            /**
             playAction(action:) START
             액션에 기능을 넣어주기
             playAction(action:) END
             */
//        }
        
//        sesac.text = "텍스트 변경"
//        sesac.text = "텍스트 또 변경"
        /**
         // 4-2.
         Field Init
         text didSet 새싹 안녕하세요
         playAction(action:) START
         액션에 기능을 넣어주기
         playAction(action:) END
         text didSet 안녕하세요 텍스트 변경
         text didSet 텍스트 변경 텍스트 또 변경
         
         // 5-1.
         Field Init
         text didSet 새싹 안녕하세요
         playAction(action:) START
         액션에 기능을 넣어주기
         playAction(action:) END
         text didSet 안녕하세요 텍스트 변경
         액션에 기능을 넣어주기  # START/END는 playAction의 기능이고, action을 실행한 것이기 때문에 프린트되지 않음
         text didSet 텍스트 변경 텍스트 또 변경
         액션에 기능을 넣어주기
         */
        
        //        viewModel.closureText = {
        //            self.formattedAmountLabel.text = self.viewModel.closureText
        //        }
        
        // 7-1.
//        viewModel.outputText.playAction {
//            self.formattedAmountLabel.text = self.viewModel.outputText.text
//        }
        
        // 31-4.
        viewModel.outputText.playAction { text in
            self.formattedAmountLabel.text = text
        }
    }
    
    
    @objc private func amountChanged() {
        print(#function)
        // 텍스트필드에 입력된 글자를 VM로 전달
        viewModel.inputField.value = amountTextField.text!
    }
}

   extension NumberRemindController {
       
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
