//
//  ListViewController.swift
//  Mbti
//
//  Created by Suji Jang on 9/2/25.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class ListViewController: BaseViewController {
    private let rightBarButton = {
        let button = UIBarButtonItem()
        button.title = "데이터전달"
        return button
    }()
    private let searchBar = UISearchBar()
    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = ListViewModel.Input(rightBarbuttonTap: rightBarButton.rx.tap, searchText: searchBar.rx.text.orEmpty, searchTap: searchBar.rx.searchButtonClicked, tableViewCellModel: tableView.rx.modelSelected(Person.self))
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as! ListTableViewCell
                cell.nameLabel.text = "\(row). \(element.name)"
                let imageUrl = URL(string: element.profileImage)
                cell.profileImageView.kf.setImage(with: imageUrl)
                cell.editButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let vc = SettingViewController()
                        vc.profileImageView.kf.setImage(with: imageUrl)
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.recentTapList
            .bind(to: collectionView.rx.items(cellIdentifier: ListCollectionViewCell.identifier, cellType: ListCollectionViewCell.self)) { (item, element, cell) in
                cell.changeLable(name: element)
            }
            .disposed(by: disposeBag)
        
        output.sendData
            .bind(with: self) { owner, data in
                let vc = DetailViewController(viewModel: DetailViewModel(receiveData: data))
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
    
    override func configureLayer() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(collectionView.snp.top).offset(-10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "List"
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

extension ListViewController {
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
