//
//  ProfileViewController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.PhotoPhoto.signiture.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.backgroundColor = .PhotoPhoto.signiture
        button.tintColor = .white
        button.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nicknameTextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해 주세요 :)"
        textField.font = .Body.regular14
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var mbtiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .Prominent.medium16
        label.textColor = .black
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray4
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraButton.layer.cornerRadius = cameraButton.bounds.width / 2
        completeButton.layer.cornerRadius = completeButton.bounds.height / 2
    }
    
    override func configureHierarcy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(nicknameTextField)
        view.addSubview(mbtiTitleLabel)
        view.addSubview(completeButton)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.size.equalTo(80)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing).offset(8)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(8)
            make.size.equalTo(30)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        mbtiTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(60)
        }
        
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "PROFILE SETTING"
    }
    
    
    @objc private func cameraButtonTapped() {
        let vc = SelectProfileImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
