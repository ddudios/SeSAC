//
//  CitySearchDetailViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class CitySearchDetailViewController: UIViewController {
    
    @IBOutlet var testLabel: UILabel!
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = data
    }
}
