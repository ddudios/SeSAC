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
    
    func configureItem(_ item: UICollectionViewCell) {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setNavigationBar(_ viewController: UIViewController, title: String) {

    }
}
