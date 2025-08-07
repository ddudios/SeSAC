//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/7/25.
//

import UIKit

extension UIViewController {
    func setColor<T: UIView>(_ view: T) {
        view.backgroundColor = .orange
        view.tintColor = .cyan
    }
}
