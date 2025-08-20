//
//  SimpleTableViewExampleViewController.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableViewExampleViewController: BaseViewController {
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //MARK: - just: 하나의 값 방출하고 즉시 완료되는 Observable을 만드는 연산자
        let items = Observable.just(
            (0...20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element) @ row \(row)"
                var config = cell.defaultContentConfiguration()
                config.text = "\(element) @ row \(row)"
                cell.contentConfiguration = config
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)  // 선택한 셀에 어떤 데이터가 들어있는지 가져옴
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
