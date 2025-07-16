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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelMagazineTableViewCell", for: indexPath) as! TravelMagazineTableViewCell
        
        // protocol collection으로 안전하게 처리해보기
//        let magazineValueCorrespondingToIndexPathRow = magazineInfo.magazine[indexPath.row]
        cell.configureCell(magazineValueCorrespondingToIndexPathRow: magazineInfo.magazine[indexPath.row])
        
        return cell
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "SeSAC TRAVEL")
        let xib = UINib(nibName: "TravelMagazineTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "TravelMagazineTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
}
