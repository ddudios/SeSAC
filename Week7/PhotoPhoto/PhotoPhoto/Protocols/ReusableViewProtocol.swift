//
//  ReusableViewProtocol.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
