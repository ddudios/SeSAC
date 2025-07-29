//
//  SearchViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Alamofire

final class SearchViewController: BaseViewController {
    
    private let shoppingSearchBar = ShoppingSearchBar()
    private let emptySearchBarTextImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noMoney")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let emptySearchBarTextLabel = EmptySearchBarTextLabel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shoppingSearchBar.text = ""
    }
    
    //MARK: - Helpers
    override func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
        view.addSubview(emptySearchBarTextImageView)
        view.addSubview(emptySearchBarTextLabel)
    }
    
    override func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(ConstraintValue.searchBarEdge)
        }
        
        emptySearchBarTextImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        emptySearchBarTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptySearchBarTextImageView.snp.bottom)
        }
    }
    
    override func configureView() {
        title = "영캠러의 쇼핑쇼핑"
        shoppingSearchBar.delegate = self
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

/*
 //MARK: - ViewDesignProtocol
 extension SearchViewController: ViewDesignProtocol {
 func configureHierarchy() {
 view.addSubview(shoppingSearchBar)
 view.addSubview(emptySearchBarTextImageView)
 view.addSubview(emptySearchBarTextLabel)
 }
 
 func configureLayout() {
 shoppingSearchBar.snp.makeConstraints { make in
 make.top.equalTo(view.safeAreaLayoutGuide)
 make.horizontalEdges.equalToSuperview().inset(ConstraintValue.searchBarEdge)
 }
 
 emptySearchBarTextImageView.snp.makeConstraints { make in
 make.centerY.equalToSuperview()
 make.horizontalEdges.equalToSuperview()
 }
 
 emptySearchBarTextLabel.snp.makeConstraints { make in
 make.centerX.equalToSuperview()
 make.top.equalTo(emptySearchBarTextImageView.snp.bottom)
 }
 }
 
 func configureView() {
 title = "영캠러의 쇼핑쇼핑"
 shoppingSearchBar.delegate = self
 }
 }
 */
