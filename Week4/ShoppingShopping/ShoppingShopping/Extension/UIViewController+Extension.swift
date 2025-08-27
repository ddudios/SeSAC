//
//  UIViewController+Extension.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit

extension UIViewController {
    static func searchLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let itemWidth = deviceWidth - (ConstraintValue.CollectionView.sideSpacingQuantity * ConstraintValue.CollectionView.inset) - (ConstraintValue.CollectionView.itemSpacingQuantity * ConstraintValue.CollectionView.itemSpacing)
        layout.itemSize = CGSize(width: itemWidth/ConstraintValue.CollectionView.itemQuantity, height: ConstraintValue.CollectionView.height)
        layout.minimumLineSpacing = ConstraintValue.CollectionView.lineSpacing
        layout.minimumInteritemSpacing = ConstraintValue.CollectionView.itemSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: ConstraintValue.CollectionView.inset, left: ConstraintValue.CollectionView.inset, bottom: ConstraintValue.CollectionView.zero, right: ConstraintValue.CollectionView.inset)
        return layout
    }
    
    static func recommendLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemHeight = ConstraintValue.CollectionView.heightScope - (ConstraintValue.CollectionView.sideSpacingQuantity * ConstraintValue.CollectionView.inset) - (ConstraintValue.CollectionView.itemSpacingQuantity * ConstraintValue.CollectionView.itemSpacing)
        layout.itemSize = CGSize(width: ConstraintValue.CollectionView.width, height: itemHeight)
        layout.minimumInteritemSpacing = ConstraintValue.CollectionView.itemSpacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: ConstraintValue.CollectionView.zero, left: ConstraintValue.CollectionView.inset, bottom: ConstraintValue.CollectionView.zero, right: ConstraintValue.CollectionView.inset)
        return layout
    }
}
