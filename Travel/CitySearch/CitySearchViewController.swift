//
//  CitySearchViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchViewController: UIViewController {
    
    let cityInfo = CityInfo()
    
    let citySearchDetailViewController = "CitySearchDetailViewController"
    let storyboardIdentifier = "CitySearchView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func testButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: citySearchDetailViewController) as! CitySearchDetailViewController
        
        vc.data = cityInfo.city.first?.city_english_name
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
