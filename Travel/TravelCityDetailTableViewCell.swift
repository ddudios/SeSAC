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
    @IBOutlet var cityDetailSaveLabel: UILabel!
    @IBOutlet var cityDetailGradeLabel: [UILabel]!
    
    @IBOutlet var cityDetailImageView: UIImageView!
    @IBOutlet var cityDetailLikeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityDetailTitleLabel.font = CustomFont.title
        cityDetailTitleLabel.textColor = .black
        
        cityDetailDescriptionLabel.numberOfLines = 0
        cityDetailDescriptionLabel.font = CustomFont.body
        cityDetailDescriptionLabel.textColor = .gray
        
        for index in 0...cityDetailGradeLabel.count - 1 {
            cityDetailGradeLabel[index].text = "★"
        }
        
        cityDetailSaveLabel.font = CustomFont.caption
        cityDetailSaveLabel.textColor = .systemGray2
        
        cityDetailImageView.layer.cornerRadius = 10
        cityDetailImageView.clipsToBounds = true
        
        cityDetailLikeButton.tintColor = .white
    }
}
