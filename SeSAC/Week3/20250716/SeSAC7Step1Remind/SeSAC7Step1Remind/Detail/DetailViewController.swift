//
//  DetailViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private var myLabel: UILabel!
    
//    var name = ""
//    var message: String? = ""
//    var phone: Int? = 0
    
    var profile: Friends = Friends(name: "", message: nil, profile_image: nil, phone: nil, like: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        myLabel.text = "\(profile.name), \(profile.message ?? "상메없음"), \(profile.phone ?? 0)"
    }
}
