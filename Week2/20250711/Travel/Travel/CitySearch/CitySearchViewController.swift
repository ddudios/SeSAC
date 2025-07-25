//
//  CitySearchViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var cityListTableView: UITableView!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    var cityList = CityInfo().city
    
    let citySearchDetailViewController = "CitySearchDetailViewController"
    let storyboardIdentifier = "CitySearchView"
    let cellIdentifier = "CitySearchTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func filterSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let all = CityInfo().city
        switch sender.selectedSegmentIndex {
        case 0:
            cityList = all
        case 1:
            var domesticArray: [City] = []
            for row in all {
                if row.domestic_travel {
                    domesticArray.append(row)
                }
            }
            cityList = domesticArray
        case 2:
            var abroadArray: [City] = []
            for row in all {
                if !row.domestic_travel {
                    abroadArray.append(row)
                }
            }
            cityList = abroadArray
        default:
            print("error: \(#function)")
        }
        cityListTableView.reloadData()
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "인기 도시")
        configureSegmentedControl()
        configureTableView()
    }
    
    func configureSegmentedControl() {
        filterSegmentedControl.setTitle("모두", forSegmentAt: 0)
        filterSegmentedControl.setTitle("국내", forSegmentAt: 1)
        filterSegmentedControl.insertSegment(withTitle: "해외", at: 2, animated: true)
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
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityListTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitySearchTableViewCell
        let row = cityList[indexPath.row]
        
        let url = URL(string: row.city_image)
        cell.cityImageView.kf.setImage(with: url)
        cell.titleLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cell.explainLabel.text = row.city_explain
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: citySearchDetailViewController) as! CitySearchDetailViewController
        
        vc.data = cityList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
