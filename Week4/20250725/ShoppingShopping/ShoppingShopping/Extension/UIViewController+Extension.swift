//
//  UIViewController+Extension.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit

extension UIViewController {
    // 내용이 너무 길어서 확장한 곳에 구현
    // 재사용 가능
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let itemWidth = deviceWidth - (ConstraintValue.CollectionView.sideSpacingQuantity * ConstraintValue.CollectionView.inset) - (ConstraintValue.CollectionView.itemSpacingQuantity * ConstraintValue.CollectionView.itemSpacing)
        layout.itemSize = CGSize(width: itemWidth/ConstraintValue.CollectionView.itemQuantity, height: ConstraintValue.CollectionView.height)
        layout.minimumLineSpacing = ConstraintValue.CollectionView.lineSpacing
        layout.minimumInteritemSpacing = ConstraintValue.CollectionView.itemSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: ConstraintValue.CollectionView.inset, left: ConstraintValue.CollectionView.inset, bottom: ConstraintValue.CollectionView.inset, right: ConstraintValue.CollectionView.inset)
        return layout
    }
}
