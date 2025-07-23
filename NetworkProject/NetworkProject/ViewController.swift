//
//  ViewController.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func lotteryButtonTapped(_ sender: UIButton) {
        let viewController = LotteryViewController()
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.modalPresentationStyle = .fullScreen
        present(navigationView, animated: true)
    }
    
    @IBAction func BoxOfficeButtonTapped(_ sender: UIButton) {
        let viewController = BoxOfficeViewController()
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.modalPresentationStyle = .fullScreen
        present(navigationView, animated: true)
    }
}

