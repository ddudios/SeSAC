//
//  TravelNewsTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/11/25.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
    
    @IBOutlet var travelMagazineImageView: UIImageView!
    @IBOutlet var travelMagazineTitleLabel: UILabel!
    @IBOutlet var travelMagazinesubtitleLabel: UILabel!
    @IBOutlet var travelMagazineDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        travelMagazineImageView.layer.cornerRadius = CornerRadiusValue.newsImage
        travelMagazineImageView.clipsToBounds = true
        travelMagazineImageView.backgroundColor = .black
        
        travelMagazineTitleLabel.font = CustomFont.headline
        travelMagazineTitleLabel.textColor = .black
        travelMagazineTitleLabel.numberOfLines = 0
        travelMagazineTitleLabel.text = """
2024 NEWS
해외여행, 이렇게 달라졌다!
"""
        
        travelMagazinesubtitleLabel.font = CustomFont.subtitle
        travelMagazinesubtitleLabel.textColor = .gray
        travelMagazinesubtitleLabel.text = "알고 준비하는 2024 새 여행"
        
        travelMagazineDateLabel.font = CustomFont.caption
        travelMagazineDateLabel.textColor = .gray
        travelMagazineDateLabel.textAlignment = .right
        travelMagazineDateLabel.text = "23년 11월 18일"
    }
}
