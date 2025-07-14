//
//  TravelNewsTableViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/11/25.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController {
    
    let magazineInfo = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelNewsCell", for: indexPath) as! TravelMagazineTableViewCell
        // protocol collection
        let magazineValueCorrespondingToIndexPathRow = magazineInfo.magazine[indexPath.row]
        let url = URL(string: magazineValueCorrespondingToIndexPathRow.photo_image)
        cell.travelMagazineImageView.kf.setImage(with: url)
        cell.travelMagazineTitleLabel.text = magazineValueCorrespondingToIndexPathRow.title
        cell.travelMagazinesubtitleLabel.text = magazineValueCorrespondingToIndexPathRow.subtitle
        cell.travelMagazineDateLabel.text = magazineValueCorrespondingToIndexPathRow.date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 510
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "SeSAC TRAVEL")
    }
}
