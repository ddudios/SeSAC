//
//  TabBarController.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case firstViewController
    case secondViewController
    case thirdViewController
    
    var title: String {
        switch self {
        case .firstViewController:
            return "Home"
        case .secondViewController:
            return "Chat"
        case .thirdViewController:
            return "Setting"
        }
    }
    
    var image: String {
        switch self {
        case .firstViewController:
            return "house"
        case .secondViewController:
            return "bubble.fill"
        case .thirdViewController:
            return "gearshape.fill"
        }
    }
    
    func viewController() -> UIViewController {
        let viewController: UIViewController
        switch self {
        case .firstViewController:
            viewController = LoginViewController()
        case .secondViewController:
            viewController = LoginViewController()
        case .thirdViewController:
            viewController = SettingViewController()
        }
        return UINavigationController(rootViewController: viewController)
    }
}

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        configureTabBarAppearance()
    }
    
    private func configureTabBarController() {
        let viewControllers = TabBarItem.allCases.map { tab -> UIViewController in
            let vc = tab.viewController()
            vc.tabBarItem = UITabBarItem(title: tab.title,
                                         image: UIImage(systemName: tab.image),
                                         tag: tab.rawValue)
            return vc
        }
        self.viewControllers = viewControllers
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBackground
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .label
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        
        // 스크롤 엣지 효과가 없을 때
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let tabBarScrollAppearance = UITabBarAppearance()
        tabBarScrollAppearance.configureWithOpaqueBackground()
        tabBarScrollAppearance.backgroundColor = .systemBackground
        
        tabBarScrollAppearance.stackedLayoutAppearance.selected.iconColor = .label
        tabBarScrollAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        tabBarScrollAppearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        tabBarScrollAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        
        // 스크롤 엣지 효과가 있을 때
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarScrollAppearance
        }
    }
}
