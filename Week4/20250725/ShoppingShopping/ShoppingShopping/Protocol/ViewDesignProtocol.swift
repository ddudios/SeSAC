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
    // 기능에 비해 받아오는 파라미터가 너무 비대하다 (UIViewController) -> BaseViewController를 만들어서 상속받는 형태로 개선
//    func configureUI(_ viewController: UIViewController) {
//        viewController.view.backgroundColor = .black
//        configureHierarchy()
//        configureLayout()
//        configureView()
//    }
    
    //TODO: 개선해보기
    func configureItem(_ item: UICollectionViewCell) {
        configureHierarchy()
        configureLayout()
        configureView()
    }
}
