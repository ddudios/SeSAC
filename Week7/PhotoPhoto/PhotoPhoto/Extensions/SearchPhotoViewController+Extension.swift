//
//  SearchPhotoViewController+Extension.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import UIKit

extension SearchPhotoViewController {
    static func createCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 10, right: 2)
        let width = (UIScreen.main.bounds.width - 6) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        
        return layout
    }
}
