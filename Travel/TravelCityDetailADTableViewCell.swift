//
//  TravelCityDetailADTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class TravelCityDetailADTableViewCell: UITableViewCell {
    
    @IBOutlet var cityDetailADBackgroundView: UIView!
    @IBOutlet var cityDetailADLabel: UILabel!
    @IBOutlet var cityDetailADBedgeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityDetailADBackgroundView.layer.cornerRadius = 8
        cityDetailADBackgroundView.clipsToBounds = true
        
        cityDetailADLabel.numberOfLines = 0
        cityDetailADLabel.font = CustomFont.title
        cityDetailADLabel.textColor = .black
        cityDetailADLabel.textAlignment = .center
        
        cityDetailADBedgeLabel.text = "AD"
        cityDetailADBedgeLabel.textColor = .black
        cityDetailADBedgeLabel.font = CustomFont.body
        cityDetailADBedgeLabel.layer.cornerRadius = 8
        cityDetailADBedgeLabel.clipsToBounds = true
        cityDetailADBedgeLabel.backgroundColor = .white
        cityDetailADBedgeLabel.textAlignment = .center
    }
    
    func configureCell(travelValueCorrespondingToPath: Travel, indexPath: IndexPath) {
        cityDetailADLabel.text = travelValueCorrespondingToPath.title
        
        if indexPath.row % 2 == 0 {
            cityDetailADBackgroundView.backgroundColor = .babyPink
        } else {
            cityDetailADBackgroundView.backgroundColor = .babyGreen
        }
    }
}
