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
            adCell.configureCell(travelValueCorrespondingToPath: travelValueCorrespondingToPath, indexPath: indexPath)
            return adCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCityDetailTableViewCell", for: indexPath) as! TravelCityDetailTableViewCell
            
            cell.configureCell(travelValueCorrespondingToPath: travelValueCorrespondingToPath)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showToast()
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
