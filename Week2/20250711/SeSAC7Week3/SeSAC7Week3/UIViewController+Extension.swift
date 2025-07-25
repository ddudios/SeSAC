//
//  UIViewController+Extension.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/14/25.
//

import UIKit

extension UIViewController {
    func setBackground() {
        view.backgroundColor = .darkGray
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "BMI 결과", message: "당신은 정상 체중입니다.", preferredStyle: .alert)
     
        let ok = UIAlertAction(title: "OK", style: .default)
        let ok2 = UIAlertAction(title: "OK2", style: .destructive)
        let ok3 = UIAlertAction(title: "OK3", style: .default)
        let ok4 = UIAlertAction(title: "OK4", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(ok4)
        alert.addAction(ok2)
        alert.addAction(ok3)
        
        present(alert, animated: true)
    }
}
