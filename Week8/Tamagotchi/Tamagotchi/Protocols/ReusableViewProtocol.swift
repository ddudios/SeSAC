//
//  ReusableViewProtocol.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
