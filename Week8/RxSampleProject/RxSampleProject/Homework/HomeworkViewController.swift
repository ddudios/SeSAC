//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class HomeworkViewController: UIViewController {
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
    
    private let viewModel = HomeworkViewModel()
    private let disposeBag = DisposeBag()
    
    private var list = BehaviorSubject<[String]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        let input = HomeworkViewModel.Input(searchButtonTap: searchBar.rx.searchButtonClicked, searchText: searchBar.rx.text.orEmpty, cellButtonTap: tableView.rx.itemAccessoryButtonTapped)
        let output = viewModel.transform(input: input)

        output.personList  // Observable
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier) as! PersonTableViewCell
                cell.usernameLabel.text = "\(element.name)"
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let detailViewModel = DetailViewModel(navigationTitle: element.name)
                        let vc = DetailViewController(viewModel: detailViewModel)
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
                
                let url = URL(string: element.profileImage)
                cell.profileImageView.kf.setImage(with: url)
                return cell
            }
            .disposed(by: disposeBag)
        
        list
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { (item, element, cell) in
                cell.changeLable(name: element)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(Person.self)
        )
        .bind(with: self) { owner, tableView in
            var value = try! owner.list.value()
            value.append(tableView.1.name)
            owner.list.onNext(value)
            print(value)
        }
        .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
