//
//  SearchResultViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

class SearchResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

}

extension SearchResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        print(#function)
    }
    
    func configureLayout() {
        print(#function)
    }
    
    func configureView() {
        print(#function)
        setNavigationBar(self, title: "캠핑카")
    }
    
    func setNavigationBar(_ viewController: UIViewController, title: String) {
        print("실제 구현")
        viewController.navigationItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .yellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        viewController.navigationController?.navigationBar.tintColor = .white
        viewController.navigationController?.navigationBar.standardAppearance = appearance
        viewController.navigationController?.navigationBar.compactAppearance = appearance
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
