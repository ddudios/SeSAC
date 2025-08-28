//
//  BaseViewController+Extension.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import UIKit
import Toast

extension BaseViewController {
    func showAlert(title: String, message: String, cancelText: String, okText: String, okHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: cancelText, style: .cancel)
        let ok = UIAlertAction(title: okText, style: .default) { _ in
            okHandler()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func messageAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // escaping 쓸 때 안쓸 때 정리하기
    /**
     어디서는 핸들러쓰고싶고 어디서는 안쓰고싶어서 @escaping없이 ( )? / 아니면 기본값을 넣어서 @escaping 명시해주거나!
     */

    // 탈출클로저는 클로저에 쓸 수 있음
    /**
     옵셔널로 감싸줌 -> 더이상 클로저로 볼 수 없을 수 있음 (타입의 관점)
     - 타입이 바껴서 더이상 이스케이핑해줘야하는 값이 아니게 됨
     -  non-escaping이 되버림 (클로저아님) -> 더이상 @escaping 붙일수 없는 상태가 된다
     
     이름없는 함순데 (() -> Void)?
     옵셔널로 한번감싸져서 이스케이핑하지 않아도 메모리에 저장이된다?
     
     따로 메모리에 저장되어있어서 얘를 다른데서 종료되도 사용
     
     class {
     내부에서 클로저 사용
     종료되도 클로저가 탈출해있으니까
     }
     
     타입관점에서 (() -> Void)?
     */
    func popAlert(title: String?, message: String, okHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            okHandler()
        }
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func showToast(message: String) {
        self.view.makeToast(message)
    }
}
