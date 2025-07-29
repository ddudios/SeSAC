//
//  UIViewController+Extension.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit

extension UIViewController {
    // 매개변수로 너무 큰 값 전달, 다른 UIViewController는 들어갈 수 없음
//    func showAlert(title: String, message: String, ok: String, vc: ViewController) {
    // 탈출 클로저 @escaping (일단 지금은 안되면 @escaping키워드 붙이자!)
    // 이미 showAlert의 메서드의 생명주기는 끝난 상태, 그래서 탈출시켜줘야 한다
    func showAlert(title: String, message: String, ok: String, okHandler: @escaping () -> Void) {
        // 이미 생명주기가 끝났다란? viewDidLoad에 이미 얼럿이 떴다
            // 얼럿이 뜬 이유는 showAlert이 이미 let alert~present까지 다 실행돼서 print1에서 print2까지 프린트된 것을 볼 수 있다
            // 그리고 나서 showAlert은 할 일을 다했기 때문에 showAlert을 부모라고 보면 부모의 생명주기는 끝난 것이다
        print("---1---")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        let ok = UIAlertAction(title: ok, style: .default) { _ in  // 매개변수 있는 것을 아니까 무작정 생략할 수 없음, _로 사용하지 않겠다 명시할 수는 있음
//            vc.view.backgroundColor = .black
//        }  // in이 보이면 클로저
        
        // 부모의 생명주기는 끝났는데 ok는 포함하고 있는 메서드의 생명이 끝났음에도 불구하고 저장 버튼을 눌렀을 때 살아있어야 한다
            // 그러려면 이것들을 빼내줘야 한다
            // 그래서 순서대로 동작하는 게 아니기 때문에 @escaping을 통해서 외부로 꺼내주는 작업이 필요하다
        // 그래서 시간이 걸리는 작업이다
            // 네트워크 통신도 비슷하다
        // SnapKit은 순서대로 실행되기 때문에 @escaping구문이 없다
        let ok = UIAlertAction(title: "저장", style: .default) { _ in
            okHandler()
            print("---3---")
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
    
        self.present(alert, animated: true)
        print("---2---")
    }
}
