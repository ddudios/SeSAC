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
        let input = SelectTamagotchiViewModel.Input(modelSelected: collectionView.rx.modelSelected(Select.self))
        let output = viewModel.transform(input: input)
        
        output.skinList
            .bind(to: collectionView.rx.items(cellIdentifier: SelectTamagotchiCollectionViewCell.identifier, cellType: SelectTamagotchiCollectionViewCell.self)) { item, element, cell in
                cell.imageView.image = UIImage(named: element.image)
                cell.nameLabel.text = element.name
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(with: self) { owner, collectionView in
                if collectionView == [0, 0] || collectionView == [0, 1] || collectionView == [0, 2] {
                    let viewController = PopupViewController()
                    let attribute = NSAttributedString(string: "변경하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor.Tamagotchi.signiture, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
                    viewController.startButton.setAttributedTitle(attribute, for: .normal)
                    viewController.modalPresentationStyle = .overFullScreen
                    viewController.select = output.select
                    owner.present(viewController, animated: false)
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
        collectionView.register(SelectTamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: SelectTamagotchiCollectionViewCell.identifier)
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
        setCollectionView()
    }
}
