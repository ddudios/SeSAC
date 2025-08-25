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
    
    private let disposeBag = DisposeBag()
    
    private let list: BehaviorRelay<[MovieInfo]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
        list
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(row + 1). \(element.movieNm)"
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(date: text)
            }
            .subscribe(with: self) { owner, boxOfficeResult in
                let data = boxOfficeResult.boxOfficeResult.dailyBoxOfficeList
                var listValue = owner.list.value
                listValue.append(contentsOf: data)
                owner.list.accept(listValue)
            } onError: { owner, error in
                print("onError boxOfficeResult")
            } onCompleted: { owner in
                print("onCompleted boxOfficeResult")
            } onDisposed: { owner in
                print("onDisposed boxOfficeResult")
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
