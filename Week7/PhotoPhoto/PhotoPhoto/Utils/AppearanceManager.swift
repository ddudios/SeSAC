//
//  AppearanceManager.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit

final class AppearanceManager {
    static func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = .white

        let nav = UINavigationBar.appearance()
        nav.standardAppearance = appearance
        nav.scrollEdgeAppearance = appearance
        nav.compactAppearance = appearance
        nav.tintColor = .black
    }

    static func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        let tab = UITabBar.appearance()
        tab.standardAppearance = appearance
        tab.scrollEdgeAppearance = appearance
        tab.tintColor = .black
        tab.unselectedItemTintColor = .systemGray6
    }
}
