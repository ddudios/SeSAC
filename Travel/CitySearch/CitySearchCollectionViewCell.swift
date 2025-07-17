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
    
    var cityData: City = City(city_name: "", city_english_name: "", city_explain: "", city_image: "", domestic_travel: false)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dump(cityData)
        citySearchCollectionImageView.backgroundColor = .orange
        citySearchCollectionImageView.contentMode = .scaleAspectFill
//        let url = URL(string: cityData.city_image)
//        citySearchCollectionImageView.kf.setImage(with: url)
        
//        cityNameLabel.text = "\(cityData.city_name) | \(cityData.city_english_name)"
        cityNameLabel.font = CustomFont.subtitle
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        
//        cityExplainLabel.text = cityData.city_explain
        cityExplainLabel.font = CustomFont.caption
        cityExplainLabel.textColor = .gray
        cityExplainLabel.numberOfLines = 0
        cityExplainLabel.textAlignment = .center
    }

}
