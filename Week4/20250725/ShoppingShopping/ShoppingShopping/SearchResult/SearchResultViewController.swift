//
//  SearchResultViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    var searchText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(self)
        NaverShoppingService.callRequest(searchText)
    }

}

extension SearchResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
        setNavigationBar(self, title: searchText)
    }
}
