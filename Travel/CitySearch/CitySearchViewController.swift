//
//  CitySearchViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var cityListTableView: UITableView!
    
    let city = CityInfo().city
    
    let citySearchDetailViewController = "CitySearchDetailViewController"
    let storyboardIdentifier = "CitySearchView"
    let cellIdentifier = "CitySearchTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "인기 도시")
        configureTableView()
    }
    
    func configureTableView() {
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        
        cityListTableView.backgroundColor = .clear
        cityListTableView.rowHeight = 180
        
        let xib = UINib(nibName: cellIdentifier, bundle: nil)
        cityListTableView.register(xib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityListTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitySearchTableViewCell
        let row = city[indexPath.row]
        
        let url = URL(string: row.city_image)
        cell.cityImageView.kf.setImage(with: url)
        cell.titleLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cell.explainLabel.text = row.city_explain
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: citySearchDetailViewController) as! CitySearchDetailViewController
        
        vc.data = city[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
