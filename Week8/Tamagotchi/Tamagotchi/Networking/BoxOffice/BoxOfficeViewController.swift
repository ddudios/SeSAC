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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.backgroundColor = .clear
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
