//
//  ProfileViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher
 
class ProfileViewController: UIViewController {

    let nickTextField = SignTextField(placeholderText: "닉네임")
    let editButton = PointButton(title: "프로필 수정")
    let logoutButton = PointButton(title: "로그아웃")
    let profileImage = UIImageView()
      
    override func viewDidLoad() {
        super.viewDidLoad()
  
        configureLayout()
        logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
    }
    
    @objc func editButtonClicked() {
        print(#function)
    }
    
    @objc func logoutButtonClicked() {
        print(#function)
    }
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(nickTextField)
        view.addSubview(editButton)
        view.addSubview(logoutButton)
        view.addSubview(profileImage)
        
        nickTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
         
        editButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nickTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(editButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalTo(view)
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
        }
         
    }
}
