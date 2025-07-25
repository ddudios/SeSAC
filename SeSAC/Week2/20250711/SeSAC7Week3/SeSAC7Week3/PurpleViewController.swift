//
//  PurpleViewController.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

class PurpleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
