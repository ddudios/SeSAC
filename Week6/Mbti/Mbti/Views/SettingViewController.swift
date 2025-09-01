//
//  SettingViewController.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    private let profileImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = 3
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    private let nicknameTextField = CustomTextField(placeholder: "닉네임을 입력해주세요")
    private let sectionTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "MBTI"
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let validateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "닉네임에 숫자는 포함할 수 없어요"
        return label
    }()
    private let eButton = RoundButton(title: "E")
    private let iButton = RoundButton(title: "I")
    private let sButton = RoundButton(title: "S")
    private let nButton = RoundButton(title: "N")
    private let tButton = RoundButton(title: "T")
    private let fButton = RoundButton(title: "F")
    private let jButton = RoundButton(title: "J")
    private let pButton = RoundButton(title: "P")
    private lazy var estjStackView = {
        let stackView = UIStackView(arrangedSubviews: [eButton, sButton, tButton, jButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var infpStackView = {
        let stackView = UIStackView(arrangedSubviews: [iButton, nButton, fButton, pButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let completeButton = RoundedRectButton(title: "완료")
    
    private let disposeBag = DisposeBag()
    private let viewModel = SettingViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func bind() {
        let input = SettingViewModel.Input(nickname: nicknameTextField.rx.text.orEmpty, eButtonTap: eButton.rx.tap, iButtonTap: iButton.rx.tap, sButtonTap: sButton.rx.tap, nButtonTap: nButton.rx.tap, tButtonTap: tButton.rx.tap, fButtonTap: fButton.rx.tap, jButtonTap: jButton.rx.tap, pButtonTap: pButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.nicknameValidateText
            .bind(to: validateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.nicknameValidateColor
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, value in
                if value {
                    owner.validateLabel.textColor = .systemBlue
                } else {
                    owner.validateLabel.textColor = .systemRed
                }
            }
            .disposed(by: disposeBag)
        
        output.eButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.eButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.iButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.iButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.sButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.sButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.nButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.nButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.tButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.tButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.fButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.fButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.jButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.jButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.pButtonStatus
            .bind(with: self) { owner, value in
                owner.setMbtiButton(owner.pButton, status: value)
            }
            .disposed(by: disposeBag)
        
        output.completeButtonStatus
            .bind(with: self) { owner, value in
                if value {
                    owner.completeButton.backgroundColor = .systemBlue
                } else {
                    owner.completeButton.backgroundColor = .systemGray
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setMbtiButton(_ button: UIButton, status: Bool) {
        if status {
            button.layer.borderWidth = 0
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
        } else {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray.cgColor
            button.backgroundColor = .clear
            button.setTitleColor(.systemGray, for: .normal)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(validateLabel)
        view.addSubview(sectionTitleLabel)
        view.addSubview(estjStackView)
        view.addSubview(infpStackView)
        view.addSubview(completeButton)
    }
    
    override func configureLayer() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        validateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview().inset(22)
        }
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(validateLabel.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        estjStackView.snp.makeConstraints { make in
            make.width.equalTo(230)
            make.height.equalTo(50)
            make.top.equalTo(validateLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        infpStackView.snp.makeConstraints { make in
            make.width.equalTo(230)
            make.height.equalTo(50)
            make.top.equalTo(estjStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "PROFILE SETTING"
    }
}
