//
//  UIViewController+Extension.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

extension UIViewController {
    func configureBackgroundColor() {
        view.backgroundColor = .brown
    }
    
    /*
    // 이렇게 해도 되긴 하는데 아쉬운 지점: 어떤 문제가 있을 수 있을까?
        // 버튼에 대한 거니까 뷰컨트롤러가 가지고 있을 필요가 없으니 버튼을 확장 -> VC의 몫이 아닌 button의 몫이 된다
    func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
     */
}
