//
//  RandomViewController.swift
//  SeSAC7Week2
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet var randomButton: UIButton!
    @IBOutlet var randomLabel: UILabel!
    
    // 왜 못쓸까?
//    let text = randomLabel.text
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = "닉네임"
        randomLabel.text = name
        randomButton.setTitle(name, for: .normal)
        
    }
}
