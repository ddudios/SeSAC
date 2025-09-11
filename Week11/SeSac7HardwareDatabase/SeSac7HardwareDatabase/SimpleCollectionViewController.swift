//
//  SimpleCollectionViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/11/25.
//

import UIKit
import SnapKit

// UICollectionViewDataSource + 'List Configuration' + CollectionViewCell
class SimpleCollectionViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var list = ["고래밥", "칙촉", "카스타드", "피자"]
    
    var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    // systemCell 사용할 것이다
    // list에서 String배열 사용중
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.dataSource = self
        configurationDataSource()
    }
    
    // Flow -> Compositional -> List Configuration
    func createLayout() -> UICollectionViewLayout {
        // UICollectionViewLayout에서 상속받아서 UICollectionViewFlowLayout
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize
//        layout.scrollDirection = .horizontal
//        layout.sectionInset
//        return layout
        
        // UICollectionViewLayout에서 상속받아서 compositional를 상속받아서 List Configuration
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)  // tableView처럼 만들 수 있게 만든게 ListConfiguration
        config.backgroundColor = .systemGreen
        config.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configurationDataSource() {
        
        // 초기화 (systemCell이기 때문에 nib파일은 필요없음, 매번 셀마다 만들지는 않음
        // extension의 정보가 여기의 매개변수로 들어옴
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            // cellForItemAt에 작성하는 코드를 이곳에 작성
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier  // list[indexPath.item]
            content.textProperties.color = .brown
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listGroupedCell()
            background.backgroundColor = .yellow
            background.cornerRadius = 40
            
            cell.backgroundConfiguration = background
        })
    }
}

// delegate는 안가져와도 됨 (didSelectItem쓸 때 사용)
extension SimpleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // (예전) custom cell + identifier + cell register
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        // systemCell이 없었기 때문에 그동안 항상 collectionView를 만들 때는 customCell identifier + 타입캐스팅했었음
        
        
        // (iOS14+) system cell(List Configuration) +   X   + cellRegistration
        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.item])
        // using: 어떤 cell, 어떤 item쓸 지 명세 (register필요없음 -> 그러니까 identifier도 필요없음)
        
        return cell
    }
    
    
}
