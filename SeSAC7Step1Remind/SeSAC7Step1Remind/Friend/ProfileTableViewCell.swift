//
//  ProfileTableViewCell.swift
//  SeSAC7Step1Remind
//
//  Created by Suji Jang on 7/18/25.
//

import UIKit
import Kingfisher

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        profileImageView.backgroundColor = .blue
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        
        desLabel.textColor = .black
    }
    
    func configureData(row: Friends) {
//        if row.phone != nil {
//            nameLabel.text = "\(row.name)님(010\(row.phone!))"
//        } else {
//            nameLabel.text = "\(row.name)님"
//        }
//        nameLabel.text = row.introduce()
        // 함수 호출하듯이 호출할 수 있음
        nameLabel.text = row.introduce  // 통로이고 직접적인 데이터를 가지지 않고 연산만 해줘서 던져줌 (함수 대신 쓸 수 있음)
        desLabel.text = row.message
        
        /*
        // 셀은 보여주기만 하면 되는데 왜 내가 킹피셔도 알아야되고 닐체크도 해야되고 신경쓸 것들이 많은가
        if row.profile_image != nil {
            let url = URL(string: row.profile_image!)
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: "star.fill")
        }*/
        if row.makeURL != nil {
            profileImageView.kf.setImage(with: row.makeURL!)
        } else {
            profileImageView.image = UIImage(systemName: "star.fill")
        }
    }
}
