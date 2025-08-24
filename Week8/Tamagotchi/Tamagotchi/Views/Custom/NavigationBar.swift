//
//  NavigationBar.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//
import UIKit

final class NavigationBar {
    static func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .Tamagotchi.background
        appearance.titleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        appearance.buttonAppearance = buttonAppearance
        
        // 스크롤 엣지 효과 없을 때
        UINavigationBar.appearance().standardAppearance = appearance
        
        let scrollAppearance = UINavigationBarAppearance()
        scrollAppearance.configureWithOpaqueBackground()
        scrollAppearance.backgroundColor = .Tamagotchi.background
        scrollAppearance.titleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        scrollAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Tamagotchi.signiture]
        
        scrollAppearance.buttonAppearance = buttonAppearance
        
        // 스크롤 엣지 효과 있을 때
        UINavigationBar.appearance().scrollEdgeAppearance = scrollAppearance
    }
}
