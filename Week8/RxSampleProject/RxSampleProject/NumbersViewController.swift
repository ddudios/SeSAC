//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NumbersViewController: BaseViewController {
    
    private let number1 = CustomTextField()
    private let number2 = CustomTextField()
    private let number3 = CustomTextField()
    private let addLable = {
        let label = UILabel()
        label.text = "+"
        label.textColor = .black
        return label
    }()
    
    private lazy var OperatorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addLable, number3])
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let seperator = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let result = UILabel()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [number1, number2, OperatorStackView, seperator, result])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .trailing
        return stackView
    }()
    
    let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 클로저 열린거 뭐지?
        // combineLatest 내부를 열어보면 클로저에서 가공해서 하나의 값으로 return
        Observable.combineLatest(
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty,
            resultSelector: { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        })
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(stackView)
    }
    
    override func configureLayout() {
        number1.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        number2.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        
        OperatorStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        addLable.snp.makeConstraints { make in
            make.width.equalTo(44)
        }
        
        number3.snp.makeConstraints { make in
            make.leading.equalTo(addLable.snp.trailing)
        }
        
        seperator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(250)
        }
    }
}
