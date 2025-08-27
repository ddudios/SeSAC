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
    //TODO: 개선해보기 (기능에 비해 파라미터가 비대)
    func configureItem(_ item: UICollectionViewCell) {
        configureHierarchy()
        configureLayout()
        configureView()
    }
}
