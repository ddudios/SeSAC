//
//  CitySearchDetailViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchDetailViewController: UIViewController {
    
    @IBOutlet var dataLabel: UILabel!
    
    var data = City(city_name: "", city_english_name: "", city_explain: "", city_image: "", domestic_travel: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = "\(data)"
        dataLabel.numberOfLines = 0
    }
}
