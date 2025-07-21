//
//  FriendCollectionViewCell.swift
//  SeSAC7Step1Remind
//
//  Created by Suji Jang on 7/17/25.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.backgroundColor = .yellow
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 17)
        
    }
    
    // 정원으로 만들기 위한 전략
    // 잘 안될 때도 있음, 왜냐하면 언제 실행될 지 명확하게 알기 어렵다
    // 셀 그리는 애한테 수정하도록
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
//        profileImageView.clipsToBounds = true
//    }
}
