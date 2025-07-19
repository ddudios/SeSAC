//
//  UIViewController+Extension.swift
//  Travel
//
//  Created by Suji Jang on 7/14/25.
//

import UIKit
import Toast

struct CustomFont {
    static let headline2 = UIFont.systemFont(ofSize: 28, weight: .semibold)
    static let subtitle = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let caption = UIFont.systemFont(ofSize: 15, weight: .medium)
    
    static let headline1 = UIFont.systemFont(ofSize: 35, weight: .bold)
    static let title1 = UIFont.systemFont(ofSize: 25, weight: .bold)
    
    static let title2 = UIFont.systemFont(ofSize: 19, weight: .bold)
    static let body = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static let chatBody = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let subhead = UIFont.systemFont(ofSize: 14, weight: .regular)
}

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

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let babyPink = UIColor.rgb(red: 255, green: 212, blue: 211)
    static let babyGreen = UIColor.rgb(red: 214, green: 255, blue: 211)
    static let babyBlue = UIColor.rgb(red: 126, green: 174, blue: 229)
}
