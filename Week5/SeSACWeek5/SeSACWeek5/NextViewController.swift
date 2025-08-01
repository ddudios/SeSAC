//
//  NextViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/1/25.
//

import UIKit
import SnapKit

class NextViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    // UICollectionViewLayout 상속받아서 Flow / Compositon
    
    // 앱이 어떻게 생겼냐에 따라 방법을 선택할 수 있다 lazy/static
    /*static*/ func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // 여백이 없어야만 잘 쓸 수 있는 기능
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: 250, height: 100)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(collectionView)
        
        // 한계: 셀 크기만큼 멈춰주는 게 아니라 디바이스 너비만큼 멈춰줌
        collectionView.isPagingEnabled = true  // 멈출 수 있는 기능
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NextCollectionViewCell.self, forCellWithReuseIdentifier: NextCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .yellow
    }
}

extension NextViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextCollectionViewCell.identifier, for: indexPath) as! NextCollectionViewCell
        return cell
    }
}
