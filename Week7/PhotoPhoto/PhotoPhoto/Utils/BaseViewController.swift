//
//  BaseViewController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarcy()
        configureLayout()
        configureView()
    }
    
    func configureHierarcy() { }
    func configureLayout() { }
    func configureView() {
        view.backgroundColor = .white
    }
}
