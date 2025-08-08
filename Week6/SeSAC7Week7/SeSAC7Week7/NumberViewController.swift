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
        
        viewModel.closureColor = {
            
        }
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
