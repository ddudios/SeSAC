//
//  SimpleValidationViewController+Extension.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/20/25.
//

import UIKit

extension SimpleValidationViewController {
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
