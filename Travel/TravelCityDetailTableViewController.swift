//
//  TravelCityDetailTableViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class TravelCityDetailTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo()
    let adBackgroundColors: [UIColor] = [.babyPink, .babyGreen]

    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travelInfoIndexPath = travelInfo.travel[indexPath.row]
        
        let adCell = tableView.dequeueReusableCell(withIdentifier: "cityDetailADCell", for: indexPath) as! TravelCityDetailADTableViewCell
        adCell.cityDetailADLabel.text = travelInfoIndexPath.title
        adCell.cityDetailADBackgroundView.backgroundColor = adBackgroundColors.randomElement()
        
        guard let ad = travelInfoIndexPath.ad else {
            print("error: \(#function) - ad Optional binding")
            return adCell
        }
        
        if ad {
//            tableView.rowHeight = 100
            return adCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityDetailCell", for: indexPath) as! TravelCityDetailTableViewCell
            
            cell.cityDetailTitleLabel.text = travelInfoIndexPath.title
            cell.cityDetailDescriptionLabel.text = travelInfoIndexPath.description
            
            guard let grade = travelInfoIndexPath.grade else {
                print("error: \(#function) - grade Optional binding")
                return cell
            }
        
            guard let save = travelInfoIndexPath.save else {
                print("error: \(#function) - save Optional binding")
                return cell
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard let numberStyle = numberFormatter.string(for: save) else {
                print("error: \(#function) numberStyle Optional binding")
                return cell
            }
            
            cell.cityDetailSaveLabel.text = "(\(grade)) ∙ 저장 \(numberStyle)"
            
            guard let image = travelInfoIndexPath.travel_image else {
                print("error: \(#function) - image Optional binding")
                return cell
            }
            
            let url = URL(string: image)
            cell.cityDetailImageView.kf.setImage(with: url)
            
            guard let like = travelInfoIndexPath.like else {
                print("error: \(#function) - like Optional binding")
                return cell
            }
            
            like ? cell.cityDetailLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : cell.cityDetailLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            
            cell.cityDetailLikeButton.tag = indexPath.row
            cell.cityDetailLikeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func configureUI() {
        tableView.rowHeight = 180
        configureNavigationBarUI()
    }
    
    func configureNavigationBarUI() {
        self.navigationItem.title = "도시 상세 정보"
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
}
