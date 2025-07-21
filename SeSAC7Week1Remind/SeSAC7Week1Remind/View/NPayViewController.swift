//
//  NPayViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/22/25.
//

import UIKit
import SnapKit

final class NPayViewController: UIViewController {
    
    private let segmentedBackgroundView = UIView()
    private let segmentedMembershipButton = UIButton()
    private let segmentedPayButton = UIButton()
    private let segmentedCouponButton = UIButton()
    private let subView = UIView()
    private let logoImageView = UIImageView()
    private let domesticButton = UIButton()
    private let closeButton = UIButton()
    private let mainImageView = UIImageView()
    private let messageLabel = UILabel()
    private let checkButton = UIButton()
    private let agreeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .nPayBackground
        
        addSubviews()
        autoLayout()
        setProperties()
    }
    
    private func addSubviews() {
        view.addSubview(segmentedBackgroundView)
        segmentedBackgroundView.addSubview(segmentedMembershipButton)
        segmentedBackgroundView.addSubview(segmentedPayButton)
        segmentedBackgroundView.addSubview(segmentedCouponButton)
        view.addSubview(subView)
        subView.addSubview(logoImageView)
        subView.addSubview(domesticButton)
        subView.addSubview(closeButton)
        subView.addSubview(mainImageView)
        subView.addSubview(messageLabel)
        subView.addSubview(checkButton)
        subView.addSubview(agreeButton)
    }
    
    private func autoLayout() {
        segmentedBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        segmentedMembershipButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(segmentedBackgroundView.snp.width).multipliedBy(0.3)
            make.leading.equalTo(segmentedBackgroundView.snp.leading).offset(8)
        }
        
        segmentedPayButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(segmentedBackgroundView.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        
        segmentedCouponButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(segmentedBackgroundView.snp.width).multipliedBy(0.3)
            make.trailing.equalTo(segmentedBackgroundView.snp.trailing).inset(8)
        }
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(segmentedBackgroundView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(500)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(15)
            make.width.equalTo(70)
            make.height.equalTo(45)
            make.leading.equalTo(subView.snp.leading).offset(20)
        }
        
        domesticButton.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(4)
            make.centerY.equalTo(logoImageView.snp.centerY).offset(-1)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-23)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(90)
            make.width.equalTo(78)
            make.height.equalTo(128)
            make.centerX.equalTo(subView.snp.centerX)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(80)
            make.centerX.equalTo(subView.snp.centerX)
        }
        
        agreeButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(subView.snp.bottom).offset(-30)
        }
    }
    
    private func setProperties() {
        configureSegmentedBackgroundView(segmentedBackgroundView)
        configureSegmentedButton(segmentedMembershipButton, title: "멤버십")
        configureSegmentedButton(segmentedPayButton, title: "현장결제", isActive: true)
        configureSegmentedButton(segmentedCouponButton, title: "쿠폰")
        configureSubView(subView)
        configureLogoImageView(logoImageView, imageString: "paymenLogoImage")
        configureDomesticButton(domesticButton, title: "국내 ▼")
        configureCloseButton(closeButton)
        configureMainImageView(mainImageView, imageString: "paymentRockImage")
        configureMessageLabel(messageLabel, message: """
한 번만 인증하고
비밀번호 없이 결제하세요
""")
        configureCheckButton(checkButton, title: " 바로결제 사용하기")
        configureAgreeButton(agreeButton, title: "확인")
    }
    
    private func configureSegmentedBackgroundView(_ view: UIView) {
        view.backgroundColor = .black
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.height / 2
        }
        view.clipsToBounds = true
    }
    
    private func configureSegmentedButton(_ button: UIButton, title: String, isActive: Bool = false) {
        if isActive {
            let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.white])
            button.setAttributedTitle(buttonTitle, for: .normal)
            button.backgroundColor = .nPaySegmentedButton
        } else {
            let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.gray])
            button.setAttributedTitle(buttonTitle, for: .normal)
            button.backgroundColor = .black
        }
        DispatchQueue.main.async {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    private func configureSubView(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }
    
    private func configureLogoImageView(_ imageView: UIImageView, imageString: String) {
        imageView.image = UIImage(named: imageString)
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configureDomesticButton(_ button: UIButton, title: String) {
        let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.subhead, NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .clear
    }
    
    private func configureCloseButton(_ button: UIButton) {
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
    }
    
    private func configureMainImageView(_ imageView: UIImageView, imageString: String) {
        imageView.image = UIImage(named: imageString)
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configureMessageLabel(_ label: UILabel, message: String) {
        label.numberOfLines = 0
        label.text = message
        label.font = .title
        label.textAlignment = .center
        label.textColor = .black
    }
    
    private func configureCheckButton(_ button: UIButton, title: String) {
        let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        button.tintColor = .nPayMain
    }
    
    private func configureAgreeButton(_ button: UIButton, title: String) {
        let buttonTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.button, NSAttributedString.Key.foregroundColor: UIColor.white])
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .nPayMain
        DispatchQueue.main.async {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}
