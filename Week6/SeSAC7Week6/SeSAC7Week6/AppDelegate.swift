//
//  AppDelegate.swift
//  SeSAC7Week6
//
//  Created by Suji Jang on 8/4/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 모든 UINavigationBar 전체에 appearance를 적용해주겠다
            // appearance()는 iOS15와는 상관없음
            // 모든 객체에 대해서 반영해주는 원래부터 있던 것
            // Font의 default변경해서 전체의 UILabel에 적용: UILabel.appearance().font = .boldSystemFont(ofSize: 14)
        UINavigationBar.appearance()
        
        // iOS15+ 등장한 Appearance: UINavigationBarAppearance클래스
        let standard = UINavigationBarAppearance()  // 최초 등장은 iOS13이고 14에 뭐가 추가되고..
        standard.backgroundColor = .yellow
        standard.titleTextAttributes = [.foregroundColor: UIColor.red]  // 네비게이션타이틀에 대한 속성
        
        // UINavigationBarAppearance를 적용
        // 프로퍼티가 standard, scrollEdge 등이 있다
            // 따라서 스크롤했을 때, 스크롤하지 않았을 때의 디자인을 똑같이 하고 싶다면, 같은 속성을 두번 적용해주면 된다
        UINavigationBar.appearance().scrollEdgeAppearance = standard
        UINavigationBar.appearance().standardAppearance = standard  // 스크롤뷰가 아예 없으면 필요없을 수 있다
        // 서로 다르게 디자인하고 싶으면 프로퍼티를 하나 더 만들어서 다른 상수에 적용해주면 된다
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

