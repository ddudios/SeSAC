//
//  CustomSearchBar.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

final class ShoppingSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        barTintColor = .black
        tintColor = .gray
        placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchTextField.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
