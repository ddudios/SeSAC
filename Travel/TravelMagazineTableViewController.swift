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
        
        let magazineIndexPathRow = magazineInfo.magazine[indexPath.row]
        let url = URL(string: magazineIndexPathRow.photo_image)
        cell.travelMagazineImageView.kf.setImage(with: url)
        cell.travelMagazineTitleLabel.text = magazineIndexPathRow.title
        cell.travelMagazinesubtitleLabel.text = magazineIndexPathRow.subtitle
        cell.travelMagazineDateLabel.text = magazineIndexPathRow.date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 510
    }
    
    func configureUI() {
        configureNavigationBarUI()
    }
    
    func configureNavigationBarUI() {
        self.navigationItem.title = "SeSAC TRAVEL"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
