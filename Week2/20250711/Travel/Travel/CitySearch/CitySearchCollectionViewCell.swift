//
//  CitySearchCollectionViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/17/25.
//

import UIKit

class CitySearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet var citySearchCollectionImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        citySearchCollectionImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.font = CustomFont.subtitle
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        
        cityExplainLabel.font = CustomFont.caption
        cityExplainLabel.textColor = .gray
        cityExplainLabel.numberOfLines = 0
        cityExplainLabel.textAlignment = .center
    }
    
    func configureData(_ row: City) {
        let url = URL(string: row.city_image)
        citySearchCollectionImageView.kf.setImage(with: url)
        
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        
        cityExplainLabel.text = row.city_explain
    }
}
