//
//  TabBarController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }

    private func configureTabs() {
        let topic = UINavigationController(rootViewController: TopicViewController())
        topic.tabBarItem = UITabBarItem(
            title: "Topic",
            image: UIImage(systemName: "flame.fill"),
            tag: 0
        )
        
        let search = UINavigationController(rootViewController: SearchPhotoViewController())
        search.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )

        setViewControllers([topic, search], animated: false)
    }
}
