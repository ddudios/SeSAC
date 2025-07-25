//
//  ViewDesignProtocol.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

protocol ViewDesignProtocol {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}


extension ViewDesignProtocol {
    func configureUI(_ viewController: UIViewController) {
        viewController.view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setNavigationBar(_ viewController: UIViewController, title: String) {
        viewController.navigationItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        viewController.navigationController?.navigationBar.tintColor = .white
        viewController.navigationController?.navigationBar.standardAppearance = appearance
        viewController.navigationController?.navigationBar.compactAppearance = appearance
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
