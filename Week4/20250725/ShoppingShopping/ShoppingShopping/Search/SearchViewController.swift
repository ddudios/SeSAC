//
//  SearchViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Alamofire

final class SearchViewController: UIViewController {
    
    private let shoppingSearchBar = ShoppingSearchBar()
    private let emptySearchBarTextImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noMoney")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let emptySearchBarTextLabel = EmptySearchBarTextLabel()

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
            
            guard let url = URL(string: NaverShoppingService(query: text, sort: "").url) else {
                print("error: URL - \(#function)")
                return
            }
            let header: HTTPHeaders = [
                APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
                APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
            ]
            AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { request in
                switch request.result {
                case .success(let value):
                    viewController.numberOfItemsInSection = value.total
                    viewController.totalLabel.text = "\(value.total) 개의 검색 결과"
                case .failure(let error):
                    print("fail: \(error)")
                }
            }
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
        setNavigationBar(self, title: "영캠러의 쇼핑쇼핑")
        setNavigationBackButton()
        
        shoppingSearchBar.delegate = self
    }
    
    private func setNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
