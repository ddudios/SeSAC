//
//  TravelCityDetailTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class TravelCityDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var cityDetailTitleLabel: UILabel!
    @IBOutlet var cityDetailDescriptionLabel: UILabel!
    @IBOutlet var cityDetailGradeLabel: UILabel!
    @IBOutlet var cityDetailSaveLabel: UILabel!
    
    @IBOutlet var cityDetailImageView: UIImageView!
    @IBOutlet var cityDetailLikeButton: UIButton!
    
//    @IBOutlet var cityDetailADBackgroundView: UIView!
//    @IBOutlet var cityDetailADLabel: UILabel!
//    @IBOutlet var cityDetailADBedgeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityDetailTitleLabel.font = CustomFont.title
        cityDetailTitleLabel.textColor = .black
        
        cityDetailDescriptionLabel.numberOfLines = 0
        cityDetailDescriptionLabel.font = CustomFont.body
        cityDetailDescriptionLabel.textColor = .gray
        
        cityDetailGradeLabel.font = CustomFont.caption
        cityDetailGradeLabel.textColor = .systemGray2
        
        cityDetailSaveLabel.font = CustomFont.caption
        cityDetailSaveLabel.textColor = .systemGray2
        
        cityDetailImageView.layer.cornerRadius = 10
        cityDetailImageView.clipsToBounds = true
        
        cityDetailLikeButton.tintColor = .white
        
        
//        cityDetailADBackgroundView.backgroundColor = .systemPink
//        
//        cityDetailADLabel.numberOfLines = 0
//        cityDetailADLabel.font = CustomFont.title
//        cityDetailADLabel.textColor = .black
//        cityDetailADLabel.textAlignment = .center
//        
//        cityDetailADBedgeLabel.text = "AD"
//        cityDetailADBedgeLabel.textColor = .black
//        cityDetailADBedgeLabel.font = CustomFont.body
//        cityDetailADBedgeLabel.layer.cornerRadius = 8
//        cityDetailADBedgeLabel.clipsToBounds = true
//        cityDetailADBedgeLabel.backgroundColor = .white
    }
}
