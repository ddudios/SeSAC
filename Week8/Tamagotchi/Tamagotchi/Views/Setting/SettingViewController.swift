//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = SettingViewModel()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
        bind()
    }
    
    private func bind() {
        // View에 표시할 Observer
//        let a = tableView.rx.modelSelected(Setting.self)
        let input = SettingViewModel.Input(modelSelected: tableView.rx.modelSelected(Setting.self))
        let output = viewModel.transform(input: input)
        
        output.items
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                cell.iconImageView.image = UIImage(systemName: element.icon)
                cell.titleLabel.text = element.title
                cell.subtitleLabel.text = element.subTitle
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asDriver(onErrorJustReturn: IndexPath(row: 0, section: 0))
            .drive(with: self) { owner, indexPath in
                if indexPath == [0, 0] {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(identifier: "NicknameSettingViewController") as! NicknameSettingViewController
                    owner.navigationController?.pushViewController(viewController, animated: true)
                } else if indexPath == [0, 1] {
                    let viewController = ChangeTamagotchiViewController()
                    owner.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    super.showAlert(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", cancelText: "아냐!", okText: "웅") {
                        UserDefaultsManager.shared.skin = UserDefaultsKey.emptyString.rawValue
                        UserDefaultsManager.shared.nickname = UserDefaultsKey.emptyNickname.rawValue
                        UserDefaultsManager.shared.level = 1
                        UserDefaultsManager.shared.rice = 0
                        UserDefaultsManager.shared.water = 0
                        
                        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                        
                        let viewController = SelectTamagotchiViewController()
                        let navigationView = UINavigationController(rootViewController: viewController)
                        sceneDelegate.window?.rootViewController = navigationView
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        setTableView()
    }
}
