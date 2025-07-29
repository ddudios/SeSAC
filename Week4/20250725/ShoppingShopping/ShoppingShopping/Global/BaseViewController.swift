//
//  BaseViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/30/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() {
        view.backgroundColor = .white
    }
    
    func showAlert(completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "네트워크 통신 실패", message: "네트워크 통신 상태를 확인하고 다시 검색해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
