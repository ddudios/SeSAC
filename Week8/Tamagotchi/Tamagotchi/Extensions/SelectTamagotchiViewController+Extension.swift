//
//  SelectTamagotchiViewController+Extension.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit

extension SelectTamagotchiViewController {
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let itemWidth = UIScreen.main.bounds.width - (20 * 2) - (16 * 2)
        layout.itemSize = CGSize(width: itemWidth / 3, height: 150)
        return layout
    }
}
