//
//  TabBarController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
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
            return "Lotto"
        case .thirdViewController:
            return "BoxOffice"
        }
    }
    
    var image: String {
        switch self {
        case .firstViewController:
            return "house"
        case .secondViewController:
            return "number"
        case .thirdViewController:
            return "film"
        }
    }
    
    func viewController() -> UIViewController {
        let viewController: UIViewController
        switch self {
        case .firstViewController:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "TamagotchiHomeViewController")
        case .secondViewController:
            viewController = LottoViewController()
        case .thirdViewController:
            viewController = BoxOfficeViewController()
            
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
        tabBarAppearance.backgroundColor = .Tamagotchi.background
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .Tamagotchi.signiture
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        
        // 스크롤 엣지 효과가 없을 때
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        // 스크롤 엣지 효과가 있을 때
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
