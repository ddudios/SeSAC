//
//  CitySearchTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var explainBackgroundView: UIView!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImageView.contentMode = .scaleAspectFill
        
//        explainBackgroundView.backgroundColor = .red
        // CALayer는 opacity 전파됨 - cornerRadius
        
        explainBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        titleLabel.textColor = .white
        titleLabel.font = CustomFont.title1
        titleLabel.textAlignment = .right
        
        explainLabel.textColor = .white
        explainLabel.font = CustomFont.caption
        explainLabel.textAlignment = .left
    }
}
