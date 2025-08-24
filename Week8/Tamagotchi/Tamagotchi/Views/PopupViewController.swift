//
//  TamagotchiPopupViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PopupViewController: BaseViewController {
    
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .Tamagotchi.background
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1-6")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        label.layer.borderWidth = 1
        label.text = " 따끔따끔 다마고치  "
        label.textColor = .Tamagotchi.signiture
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    private let seperator = {
        let view = UIView()
        view.backgroundColor = .Tamagotchi.signiture.withAlphaComponent(0.5)
        return view
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
//        label.text = """
//            저는 방실방실 다마고치입니당 키는 100km
//            몸무게는 150톤이에용
//            성격은 화끈하고 날라다닙니당~!
//            열심히 잘 먹고 잘 클 자신은
//            있답니당 방실방실!
//            """
        label.text = """
            저는 선인장 다마고치 입니다. 키는 2cm 몸무게는 150g이에요.
            성격은 소심하지만 마음은 따뜻해요.
            열심히 잘 먹고 잘 클 자신은 있답니다.
            반가워요 주인님!!!
            """
        label.textColor = .Tamagotchi.signiture
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buttonSeperator = {
        let view = UIView()
        view.backgroundColor = .Tamagotchi.signiture.withAlphaComponent(0.4)
        return view
    }()
    
    private let cancelButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "취소", attributes: [NSAttributedString.Key.foregroundColor : UIColor.Tamagotchi.signiture, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        button.setAttributedTitle(attribute, for: .normal)
        button.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        button.layer.borderWidth = 0.4
        return button
    }()
    
    private let startButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "시작하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor.Tamagotchi.signiture, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        button.setAttributedTitle(attribute, for: .normal)
        button.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        button.layer.borderWidth = 0.4
        return button
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = PopupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    private func bind() {
        let input = PopupViewModel.Input()
        let output = viewModel.transform(input: input)
        
        cancelButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.cancel()
            }
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                UserDefaultsManager.shared.skin = Skin.flash.rawValue
                
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "TamagotchiHomeViewController")
                sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
            }
            .disposed(by: disposeBag)

        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .asDriver()
            .drive(with: self) { owner, gesture in
                let location = gesture.location(in: owner.view)
                if !owner.containerView.frame.contains(location) {
                    owner.dismiss(animated: false)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    private func cancel() {
        self.dismiss(animated: false)
    }
    
    override func configureHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(seperator)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(buttonSeperator)
        containerView.addSubview(cancelButton)
        containerView.addSubview(startButton)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(152)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.horizontalEdges.equalToSuperview().inset(100)
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(110)
            make.height.equalTo(25)
        }
        
        seperator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(seperator.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(100)
        }
        
        buttonSeperator.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.height.equalTo(0.4)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonSeperator.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(buttonSeperator.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalTo(cancelButton.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
    }
}
