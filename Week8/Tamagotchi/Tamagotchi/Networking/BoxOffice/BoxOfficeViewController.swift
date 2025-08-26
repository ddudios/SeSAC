//
//  BoxOfficeViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BoxOfficeViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    private let viewModel = BoxOfficeViewModel()
    private let disposeBag = DisposeBag()
    
//    private let list: BehaviorRelay<[MovieInfo]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        //        let a = searchBar.rx.searchButtonClicked
        //        let b = searchBar.rx.text.orEmpty
        let input = BoxOfficeViewModel.Input(returnSearch: searchBar.rx.searchButtonClicked, searchText: searchBar.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(row + 1). \(element.movieNm)"
            }
            .disposed(by: disposeBag)
        
        output.alertMessage
            .bind(with: self) { owner, message in
                owner.messageAlert(title: "네트워크 단절 에러", message: message)
            }
            .disposed(by: disposeBag)
        
        output.toastMessage
            .bind(with: self) { owner, message in
                owner.showToast(message: message)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "박스오피스"
        searchBar.placeholder = "yyyyMMdd"
        setTableView()
    }
}
