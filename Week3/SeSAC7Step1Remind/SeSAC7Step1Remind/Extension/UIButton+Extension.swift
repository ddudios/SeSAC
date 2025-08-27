//
//  UIButton+Extension.swift
//  SeSAC7Step1Remind
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

extension UIButton {
    func configure(title: String) {
        self.setTitle(title, for: .normal)  // 인스턴스 프로퍼티
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
