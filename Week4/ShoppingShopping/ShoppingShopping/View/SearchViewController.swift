//
//  SearchViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let shoppingSearchBar = ShoppingSearchBar()
    private let emptySearchBarTextImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noMoney")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emptySearchBarTextLabel = EmptySearchBarTextLabel()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewDidLoad.data = ()
    }
    
    //MARK: - Helpers
    private func bindData() {
        viewModel.output.text.bind { text in
            self.shoppingSearchBar.text = text
        }
        
        viewModel.output.searchBarSearchButtonClicked.lazyBind { text in
            let vc = SearchResultViewController()
            vc.viewModel.output.title.data = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func bind() {
        let input = SearchViewModel.RxInput(searchBarTap: shoppingSearchBar.rx.searchButtonClicked, searchText: shoppingSearchBar.rx.text.orEmpty)
        let output = viewModel.transform(rxInput: input)
        
        output.list
            .bind(with: self) { owner, item in
                print("print@@@@", item)
            }
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(row + 1). \(element.movieNm)"
//            }
            .disposed(by: disposeBag)
    }
    
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
        
        viewModel.input.textField.data = searchBar.text
        viewModel.input.searchBarSearchButtonClicked.data = ()
    }
}
