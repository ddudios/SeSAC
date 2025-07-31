//
//  SceneDelegate.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }  // 씬이 존재하는지 확인 (여기서 실패할 일은 거의 없다)
        window = UIWindow(windowScene: scene)  // 유리를 만들어줌
        let nav = UINavigationController(rootViewController: PhotoViewController())// 네비게이션 임베드
        window?.rootViewController = nav  // 가장 밑에 차지해야하는 첫 화면을
        window?.makeKeyAndVisible()  // 이 윈도우에 뭐가 들어있다면 사용자 눈에 시각적으로 보이게 해달라
            // 특정 버전에서는 쓰지 않아도 되지만 고려하지 않고 그냥 씀
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

