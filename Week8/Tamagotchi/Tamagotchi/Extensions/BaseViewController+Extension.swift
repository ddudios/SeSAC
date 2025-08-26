//
//  BaseViewController+Extension.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit
import Toast

extension BaseViewController {
    func showAlert(title: String, message: String, cancelText: String, okText: String, okHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: cancelText, style: .cancel)
        let ok = UIAlertAction(title: okText, style: .default) { _ in
            okHandler()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func messageAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // escaping 쓸 때 안쓸 때 정리하기
    func popAlert(title: String?, message: String, okHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            okHandler()
        }
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func showToast(message: String) {
        self.view.makeToast(message)
    }
}
