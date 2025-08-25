//
//  LottoViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LottoViewController: BaseViewController {
    
    private let textField = {
        let textField = UITextField()
        textField.tintColor = .Tamagotchi.signiture
        textField.borderStyle = .roundedRect
        textField.placeholder = "회차"
        return textField
    }()
    
    private let resultButton = {
        let button = UIButton()
        button.setTitle("결과", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .Tamagotchi.signiture
        return button
    }()
    
    private let resultLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "결과"
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        resultButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty)
            .map { CustomObservable.getLotto(query: $0)
                .debug("Observable<Observable<Int>>") }
            .debug("buttonTap")
            .subscribe(with: self) { owner, observable in
                print("LottoObservable onNext", observable)
                observable
                    .bind(with: self) { owner, lotto in
                        owner.resultLabel.text = "\(lotto.drwtNo1) / \(lotto.drwtNo2) / \(lotto.drwtNo3) / \(lotto.drwtNo4) / \(lotto.drwtNo5) / \(lotto.drwtNo6) (bonus:\(lotto.bnusNo))"
                    }
                    .disposed(by: owner.disposeBag)
            } onError: { owner, error in
                print("LottoObservable onError", error)
            } onCompleted: { owner in
                print("LottoObservable onCompleted")
            } onDisposed: { owner in
                print("LottoObservable onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "Lotto"
    }
}
