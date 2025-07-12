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
        let travelInfoIndexPath = travelInfo.travel[indexPath.row]
        
        let adCell = tableView.dequeueReusableCell(withIdentifier: "cityDetailADCell", for: indexPath) as! TravelCityDetailADTableViewCell
        adCell.cityDetailADLabel.text = travelInfoIndexPath.title
        if indexPath.row % 2 == 0 {
            adCell.cityDetailADBackgroundView.backgroundColor = .babyPink
        } else {
            adCell.cityDetailADBackgroundView.backgroundColor = .babyGreen
        }
        
        guard let ad = travelInfoIndexPath.ad else {
            print("error: \(#function) - ad Optional binding")
            return adCell
        }
        
        if ad {
            // 왜 버튼을 누르면 높이가 바뀌지?
            tableView.rowHeight = 100
            return adCell
        } else {
            tableView.rowHeight = 180
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityDetailCell", for: indexPath) as! TravelCityDetailTableViewCell
            
            cell.cityDetailTitleLabel.text = travelInfoIndexPath.title
            cell.cityDetailDescriptionLabel.text = travelInfoIndexPath.description
            
            guard let grade = travelInfoIndexPath.grade else {
                print("error: \(#function) - grade Optional binding")
                return cell
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
            
            cell.cityDetailSaveLabel.text = "(\(numberStyle)) ∙ 저장 \(numberStyle)"
            
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
    }
    
    // 왜 안되지?
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let ad = travelInfo.travel[indexPath.row].ad {
//            if ad {
//                return 100
//            } else {
//                return 180
//            }
//        } else {
//            print("error: \(#function) - ad Optional binding")
//            return 0
//        }
//    }
    
    func configureUI() {
//        tableView.rowHeight = 180
        configureNavigationBarUI()
    }
    
    func configureNavigationBarUI() {
        self.navigationItem.title = "도시 상세 정보"
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        
        guard let ad = travelInfo.travel[sender.tag].ad else {
            print("error: \(#function) - ad Optional binding")
            return
        }
        if ad {
            tableView.rowHeight = 100
        } else {
            tableView.rowHeight = 180
        }
        tableView.reloadData()
    }
}
