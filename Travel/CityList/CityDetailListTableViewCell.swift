//
//  TravelCityDetailTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class CityDetailListTableViewCell: UITableViewCell {
    
    @IBOutlet var cityDetailTitleLabel: UILabel!
    @IBOutlet var cityDetailDescriptionLabel: UILabel!
    @IBOutlet var cityDetailSaveLabel: UILabel!
    @IBOutlet var cityDetailGradeLabel: [UILabel]!
    
    @IBOutlet var cityDetailImageView: UIImageView!
    @IBOutlet var cityDetailLikeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityDetailTitleLabel.font = CustomFont.title2
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
    
    func configureCell(travelValueCorrespondingToPath: Travel) {
        cityDetailTitleLabel.text = travelValueCorrespondingToPath.title
        cityDetailDescriptionLabel.text = travelValueCorrespondingToPath.description
        
        guard let grade = travelValueCorrespondingToPath.grade else {
            print("error: \(#function) - grade Optional binding")
            return
        }
        
        var grades = [false, false, false, false, false]
        
        switch grade {
        case 0..<1:
            grades = [false, false, false, false, false]
        case 1..<2:
            grades = [true, false, false, false, false]
        case 2..<3:
            grades = [true, true, false, false, false]
        case 3..<4:
            grades = [true, true, true, false, false]
        case 4..<5:
            grades = [true, true, true, true, false]
        case 5..<6:
            grades = [true, true, true, true, true]
        default:
            print("error: \(#function) - grade switch")
        }
        
        for index in 0...cityDetailGradeLabel.count - 1 {
            cityDetailGradeLabel[index].font = CustomFont.caption
            if grades[index] {
                cityDetailGradeLabel[index].textColor = .orange
            } else {
                cityDetailGradeLabel[index].textColor = .systemGray2
            }
        }
        
        guard let save = travelValueCorrespondingToPath.save else {
            print("error: \(#function) - save Optional binding")
            return
        }
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let numberStyle = numberFormatter.string(for: save) else {
            print("error: \(#function) numberStyle Optional binding")
            return
        }
        
        cityDetailSaveLabel.text = "(\(numberStyle)) ∙ 저장 \(numberStyle)"
        
        guard let image = travelValueCorrespondingToPath.travel_image else {
            print("error: \(#function) - image Optional binding")
            return
        }
        
        let url = URL(string: image)
        cityDetailImageView.kf.setImage(with: url)
        
        guard let like = travelValueCorrespondingToPath.like else {
            print("error: \(#function) - like Optional binding")
            return
        }
        
        like ? cityDetailLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : cityDetailLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
