//
//  ThirdViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {
    
    let button = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
    
        button.rx.tap
            .bind(with: self) { owner, _ in
                let vc = SettingViewController()
                vc.modalPresentationStyle = .fullScreen
                owner.present(vc, animated: true)
                
                // 앱실행시 만든 퍼스트뷰컨은 아님
                /*
                let a = FirstViewController()
                a.view.backgroundColor = .red
                let b = FirstViewController()
                SceneDelegate().window = SettingViewController()  // 사용자가 처음부터 앱을 시작하는 것처럼 (이렇게 만들면 새로운 씬델리게이트를 만드는 것이기 때문에 안됨)
                 */
                owner.changeRootVC()
            }
            .disposed(by: disposeBag)
    }
    
    private func changeRootVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                // App델리게이트에서 UIApplication를 통해서 Scene델리게이트에서 UIScene 등 모든 플로우가 연결되어있음
              let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
              // 씬델리게이트의 window객체가 맞는지에 대한 점검
        
        //씬델리게이트 파일에 들어올 수 있고 그 파일의 윈도우객체 변경
        sceneDelegate.window?.rootViewController = SettingViewController()
        
        // 루트뷰컨트롤러를 교체해버리면서 그동안 쌓여있던 객체들을 다 디이닛해버림
        
        // 자연스러운 변경
        UIView.transition(with: sceneDelegate.window!, duration: 0.5, options: .transitionFlipFromRight) { }
    }
    
    deinit {
        print("Third Deinit")
    }
}
