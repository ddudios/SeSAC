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
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let babyPink = UIColor.rgb(red: 255, green: 212, blue: 211)
    static let babyGreen = UIColor.rgb(red: 214, green: 255, blue: 211)
}
