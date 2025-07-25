//
//  UIViewController+Extension.swift
//  Travel
//
//  Created by Suji Jang on 7/14/25.
//

import UIKit
import Toast

struct CornerRadiusValue {
    static let newsImage: CGFloat = 20
}

extension UIViewController {
    func configureNavigationBarUI(title: String) {
        self.navigationItem.title = title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func showToast() {
        // 어떤 뷰를 기준으로 토스트를 띄우는지
        view.makeToast("", duration: 1, point: CGPoint(x: 200, y: 650), title: "광고 셀입니다", image: nil, completion: nil)
    }
}
