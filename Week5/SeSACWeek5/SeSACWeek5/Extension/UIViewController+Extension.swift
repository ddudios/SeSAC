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
        // 이미 생명주기가 끝났다란? viewDidLoad에 이미 얼럿이 떴다: 이미 1, 2 모두 실행됨
        print("---1---")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // in이 보이면 클로저
//        let ok = UIAlertAction(title: ok, style: .default) { _ in  // 매개변수 있는 것을 아니까 무작정 생략할 수 없음, _로 사용하지 않겠다 명시할 수는 있음
//            vc.view.backgroundColor = .black
//        }
        let ok = UIAlertAction(title: "저장", style: .default) { _ in
            okHandler()
            print("---3---")  // (12:21)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
    
        self.present(alert, animated: true)
        print("---2---")
    }
}

// 기존에 다룬 함수는
    // 함수 박스 안에 함수가 들어가서 끝나는 구조
// 얼럿의 경우에는
    // 이미 블럭이 있음, 그 블럭 안에 블럭을 넣음
    // 더 많은 블럭이 (12:18+캡쳐) 한 번 더 탈출
// 스냅킷은 순서대로 실행돼서 @escaping 없음
