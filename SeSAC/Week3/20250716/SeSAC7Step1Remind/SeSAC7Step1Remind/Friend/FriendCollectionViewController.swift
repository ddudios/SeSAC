//
//  FriendColleoctionViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Suji Jang on 7/17/25.
//

import UIKit

class FriendCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    /*
     TableView -> CollectionView로 복습 / row -> item
     1. collectionView 아웃렛 연결
     2. 부하직원 호출
     */
    
    @IBOutlet var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: "FriendCollectionViewCell", bundle: nil)
        myCollectionView.register(xib, forCellWithReuseIdentifier: "FriendCollectionViewCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        // 셀의 너비와 높이도 설정하는 것이 필요함
            // 보통 고정하지 않고 비율로 수치를 잡음
        let layout = UICollectionViewFlowLayout()  // Min Spacing등을 인스펙터에서 조정한 것을 코드로 하는 방법
        let deviceWidth = UIScreen.main.bounds.width  // 디바이스에 따라 유동적으로 변하는 너비
        let cellWidth = deviceWidth - (16 * 2) - (16 * 3)  // 간격의 변동이 많기 때문에 계산하지 않고 씀: (처음,끝) (셀사이간격갯수)
        layout.itemSize = CGSize(width: cellWidth/4, height: cellWidth/4)  // 셀 갯수 변동
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        myCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
        
        // 1. 처음에 어떻게 너비가 측정될까?
            // XIB에서 디자인한 크기 기준을 통해서 처음에 레이아웃이 잡힌다 (셀의 XIB 크기가 140으로 잡혀있으면 /2 -> 70 -> 마름모)
            // 제약조건 기준으로 잡히는데 기준이 부족하니까 XIB 설정된 상태로 눈에 보임 (절대적인 너비로 먼저 그리고 일단 보여준 다음에 바꿀게 있으면 변경)
            // XIB대로 Constraints > Layout > Display > Update
            // 일단 그리는 시점이 사용자 눈에 보이는 시점이라서, 이미 뜨고 난 다음에 Update이기 때문에 스크롤 왔다갔다하면 정원으로 바뀜(10:14)
            // 디스플레이 전에는 엑스아이비, 디스플레이 이후 알맞게 업데이트
            // 스크롤했을때 알맞게 될 수 있도록 만드는 코드 필요
//        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
//        cell.profileImageView.clipsToBounds = true
        print("==cellForItemAt==1==")
        DispatchQueue.main.async {
            print("==cellForItemAt==2==")
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
        }
        print("==cellForItemAt==3==")
        cell.profileImageView.clipsToBounds = true
        
        cell.nameLabel.text = "\(indexPath)\(indexPath.item)"
        
        return cell
    }
}
