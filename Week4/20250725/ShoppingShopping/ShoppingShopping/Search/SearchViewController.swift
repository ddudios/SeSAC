//
//  SearchViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let shoppingSearchBar = UISearchBar()
    
    lazy var testButton = {
        let button = UIButton()
        button.setTitle("dfasdf", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func buttonTapped() {
        let viewController = SearchResultViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(testButton)
    }
    
    func configureLayout() {
        testButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.height.width.equalTo(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        setNavigationBar(self, title: "영캠러의 쇼핑쇼핑")
        setNavigationBackButton()
    }
    
    func setNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
