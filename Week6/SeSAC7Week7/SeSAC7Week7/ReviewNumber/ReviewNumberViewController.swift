//
//  ReviewNumberViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class ReviewNumberViewController: UIViewController {
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₩0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = ReviewNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        bindData()
        

    }
    
    func reminde() {
        // 데이터 바꼈을 때 바뀐 결과를 알고싶을 때마다 print 코드를 작성해야 했다
        var a = 1
        var b = 2
        print(a + b)
        
        a = 3
        b = 4
        print(a + b)
        
        var c = ReviewObservable(1)  // 누가 들어가도 상관없음
        var d = ReviewObservable(2)
        // 옵저버블 클래스가 랩핑중: ReviewObservable + ReviewObservable 불가능
        print(c.value + d.value)
        
        // c가 갖고있는 value가 변경될때마다 실행시키고 싶은 함수를 넣어줌
        c.bind {
            print(c.value + d.value)
        }
        
        c.value = 3  // UIKit 특성상, 데이터가 바뀌면 뷰는 따로 놀아서 맞춰줘야 한다 -> 데이터 변경이 생기면 알아서 맞춰지도록 코드 개선
        c.value = 60
        c.value = 1000
        
        d.value = 30  // d는 변경돼도 print가 되지 않음 (c가 바뀔때만 프린트하도록 코드 구성)
        
        d.bind {
            print(c.value + d.value)
        }
        d.value = 1  // 1001
        
        // 스유는 상태기반으로 움직이는데 이렇게 구성하면 유킷도 상태기반처럼 움직이게 만듦
        // Rx, Combine 둘 중 하나만 잘하면 됨 (결국은 사용법이라), 둘 다 사용하지 않고 직접 반응형으로 Observable 작성하는 과제가 생길 수 있음
        // Rx, Combine을 쓰지 않고도 반응형을 작성할 수 있다
    }
    
    func bindData() {
        viewModel.output.amount.bind {
            // 감이 잘 안오면 다 print해보기
            print("outputAmount 달라짐", self.viewModel.output.amount.value)
            /**
             amountChanged()
             inputAmount 달라짐
             숫자만 입력해주세요
             outputAmount 달라짐 숫자만 입력해주세요
             */
            
            // output이 달라지면 하고 싶은 내용은 bind 내부에 작성
                // 내용은 label의 글자를 바꿔주고 싶음 (VC에서 가능) -> 보통 output의 bind는 VC에서 작성
            self.formattedAmountLabel.text = self.viewModel.output.amount.value
        }
    }
    
    
    @objc private func amountChanged() {
        print(#function)
        viewModel.input.amount.value = amountTextField.text
        /**
         메서드 호출마다 프린트 찍힘:
         amountChanged()
         inputAmount 달라짐
         */
    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        
        let open = UIAlertAction(title: "확인", style: .default) { _ in
           
        }
        
        let delete = UIAlertAction(title: "삭제",
                                   style: .destructive)
        
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)
        
        
        alert.addAction(cancel)
        alert.addAction(delete)
        alert.addAction(open)
        
        
        present(alert, animated: true)
        
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
        view.addSubview(convertedAmountLabel)
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
        
        convertedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(formattedAmountLabel.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }
    
    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }
}
