//
//  TravelCityDetailTableViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class CityDetailListTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo()
    
    let adDetailViewController = "AdDetailViewController"
    let cityDetailViewController = "CityDetailViewController"

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
            let adCell = tableView.dequeueReusableCell(withIdentifier: CityDetailListADTableViewCell.identifier, for: indexPath) as! CityDetailListADTableViewCell
            adCell.configureCell(travelValueCorrespondingToPath: travelValueCorrespondingToPath, indexPath: indexPath)
            return adCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailListTableViewCell.identifier, for: indexPath) as! CityDetailListTableViewCell
            
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
        guard let ad = travelInfo.travel[indexPath.row].ad else {
            print("error: \(#function) - ad Optional binding")
            return
        }
        if ad {
            showToast()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: adDetailViewController) as! AdDetailViewController
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: adDetailViewController) as! AdDetailViewController
            let navigationView = UINavigationController(rootViewController: viewController)
            navigationView.modalPresentationStyle = .fullScreen
            present(navigationView, animated: true)
        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: cityDetailViewController) as! CityDetailViewController
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: cityDetailViewController) as! CityDetailViewController
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "도시 상세 정보")
        
        let xib = UINib(nibName: CityDetailListTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: CityDetailListTableViewCell.identifier)
        
        let adXib = UINib(nibName: CityDetailListADTableViewCell.identifier, bundle: nil)
        tableView.register(adXib, forCellReuseIdentifier: CityDetailListADTableViewCell.identifier)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
}
