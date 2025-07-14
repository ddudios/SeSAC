//
//  TravelCityDetailTableViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class TravelCityDetailTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo()

    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travelValueCorrespondingToPath = travelInfo.travel[indexPath.row]
        
        guard let ad = travelValueCorrespondingToPath.ad else {
            print("error: \(#function) - ad Optional binding")
            return UITableViewCell()
        }
        
        if ad {
            let adCell = tableView.dequeueReusableCell(withIdentifier: "TravelCityDetailADTableViewCell", for: indexPath) as! TravelCityDetailADTableViewCell
            adCell.cityDetailADLabel.text = travelValueCorrespondingToPath.title
            
            if indexPath.row % 2 == 0 {
                adCell.cityDetailADBackgroundView.backgroundColor = .babyPink
            } else {
                adCell.cityDetailADBackgroundView.backgroundColor = .babyGreen
            }
            
            return adCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCityDetailTableViewCell", for: indexPath) as! TravelCityDetailTableViewCell
            
            cell.cityDetailTitleLabel.text = travelValueCorrespondingToPath.title
            cell.cityDetailDescriptionLabel.text = travelValueCorrespondingToPath.description
            
            guard let grade = travelValueCorrespondingToPath.grade else {
                print("error: \(#function) - grade Optional binding")
                return UITableViewCell()
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
            
            for index in 0...cell.cityDetailGradeLabel.count - 1 {
                cell.cityDetailGradeLabel[index].font = CustomFont.caption
                if grades[index] {
                    cell.cityDetailGradeLabel[index].textColor = .orange
                } else {
                    cell.cityDetailGradeLabel[index].textColor = .systemGray2
                }
            }
            
            guard let save = travelValueCorrespondingToPath.save else {
                print("error: \(#function) - save Optional binding")
                return UITableViewCell()
            }
            
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard let numberStyle = numberFormatter.string(for: save) else {
                print("error: \(#function) numberStyle Optional binding")
                return UITableViewCell()
            }
            
            cell.cityDetailSaveLabel.text = "(\(numberStyle)) ∙ 저장 \(numberStyle)"
            
            guard let image = travelValueCorrespondingToPath.travel_image else {
                print("error: \(#function) - image Optional binding")
                return UITableViewCell()
            }
            
            let url = URL(string: image)
            cell.cityDetailImageView.kf.setImage(with: url)
            
            guard let like = travelValueCorrespondingToPath.like else {
                print("error: \(#function) - like Optional binding")
                return UITableViewCell()
            }
            
            like ? cell.cityDetailLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : cell.cityDetailLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            
            cell.cityDetailLikeButton.tag = indexPath.row
            cell.cityDetailLikeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let ad = travelInfo.travel[indexPath.row].ad {
            if ad {
                return 100
            } else {
                return 180
            }
        } else {
            print("error: \(#function) - ad Optional binding")
            return 0
        }
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "도시 상세 정보")
        
        let xib = UINib(nibName: "TravelCityDetailTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "TravelCityDetailTableViewCell")
        
        let adXib = UINib(nibName: "TravelCityDetailADTableViewCell", bundle: nil)
        tableView.register(adXib, forCellReuseIdentifier: "TravelCityDetailADTableViewCell")
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
}
