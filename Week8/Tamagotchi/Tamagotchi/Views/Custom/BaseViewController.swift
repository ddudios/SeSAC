//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setNavigationBarButton() {
        let backbutton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backbutton.tintColor = .Tamagotchi.signiture
        navigationItem.backBarButtonItem = backbutton
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() {
        view.backgroundColor = .Tamagotchi.background
        setNavigationBarButton()
    }
}
