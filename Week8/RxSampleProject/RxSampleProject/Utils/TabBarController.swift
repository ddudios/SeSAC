//
//  TabBarController.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/19/25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }

    private func configureTabs() {
        let num = UINavigationController(rootViewController: NumbersViewController())
        num.tabBarItem = UITabBarItem(
            title: "numbers",
            image: UIImage(systemName: "number"),
            tag: 0
        )
        
        let table = UINavigationController(rootViewController: SimpleTableViewExampleViewController())
        table.tabBarItem = UITabBarItem(
            title: "table",
            image: UIImage(systemName: "table"),
            tag: 1
        )
        
        let validation = UINavigationController(rootViewController: SimpleValidationViewController())
        validation.tabBarItem = UITabBarItem(
            title: "validation",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 2
        )

        setViewControllers([num, table, validation], animated: false)
    }
}
