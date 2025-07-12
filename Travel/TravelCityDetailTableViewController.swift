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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityDetailCell", for: indexPath) as! TravelCityDetailTableViewCell
        
        let travelInfoIndexPath = travelInfo.travel[indexPath.row]
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func configureUI() {
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
