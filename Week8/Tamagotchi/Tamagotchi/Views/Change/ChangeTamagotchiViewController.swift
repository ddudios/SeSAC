//
//  ChangeTamagotchiViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChangeTamagotchiViewController: BaseViewController {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
    
    private let disposeBag = DisposeBag()
    private let viewModel = SelectTamagotchiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = SelectTamagotchiViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.skinList
            .bind(to: collectionView.rx.items(cellIdentifier: ChangeTamagotchiCollectionViewCell.identifier, cellType: ChangeTamagotchiCollectionViewCell.self)) { item, element, cell in
                cell.imageView.image = UIImage(named: element.image)
                cell.nameLabel.text = element.name
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(with: self) { owner, collectionView in
                if collectionView == [0, 0] {
                    let viewController = PopupViewController()
                    viewController.modalPresentationStyle = .overFullScreen
                    owner.present(viewController, animated: false)
                } else if collectionView == [0, 1] {
                    let viewController = PopupViewController()
                    viewController.modalPresentationStyle = .overFullScreen
                    owner.present(viewController, animated: false)
                } else if collectionView == [0, 2] {
                    let viewController = PopupViewController()
                    viewController.modalPresentationStyle = .overFullScreen
                    owner.present(viewController, animated: false)
//                    UserDefaultsManager.shared.skin = Skin.flash.rawValue
//                    owner.goToHome()
                } else {
                    print("셀클릭")
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func goToHome() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TamagotchiHomeViewController") as! TamagotchiHomeViewController
        let navigationView = UINavigationController(rootViewController: viewController)
        
        sceneDelegate.window?.rootViewController = navigationView
    }
    
    private func setCollectionView() {
        collectionView.register(ChangeTamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: ChangeTamagotchiCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "다마고치 변경하기"
        
        setCollectionView()
    }
}
