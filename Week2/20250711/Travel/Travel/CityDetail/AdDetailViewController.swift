//
//  AdDetailViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet var adLabel: UILabel!
    
    var adTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "광고 화면")
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        configureLabel(adLabel)
    }
    
    func configureLabel(_ label: UILabel) {
        label.text = adTitle
        label.font = CustomFont.title1
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
}
