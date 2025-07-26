//
//  File.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

//MARK: 원래 안되는건지... 내가못한건지...
final class SearchResultCollectionViewUI: UICollectionView {
    let layout = UICollectionViewFlowLayout()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        collectionViewLayout = config()
        backgroundColor = .yellow
        register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() -> UICollectionViewFlowLayout  {
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ConstraintValue.CollectionView.lineSpacing
        layout.minimumInteritemSpacing = ConstraintValue.CollectionView.inset
        return layout
    }
}
