//
//  BaseViewController.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayer()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayer() { }
    func configureView() {
        view.backgroundColor = .white
    }
}
