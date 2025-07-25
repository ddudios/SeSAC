//
//  SearchViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let shoppingSearchBar = ShoppingSearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(self)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            print("error: \(#function)")
            return
        }
        
        if text.count > 1 {
            let viewController = SearchResultViewController()
            viewController.searchText = text
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("error: \(#function) - 2글자 이상 입력해야 합니다")
        }
    }
}

//MARK: - ViewDesignProtocol
extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
    }
    
    func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(ConstraintValue.searchBarEdge)
        }
    }
    
    func configureView() {
        setNavigationBar(self, title: "영캠러의 쇼핑쇼핑")
        setNavigationBackButton()
        
        shoppingSearchBar.delegate = self
    }
    
    func setNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
