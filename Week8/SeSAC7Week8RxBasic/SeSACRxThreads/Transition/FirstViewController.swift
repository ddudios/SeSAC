//
//  FirstViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {
    
    let button = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
    var count = 0
    
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
                
                owner.count += 1
                print(owner.count)  // 1. print: 한줄 한줄 리소스라고 생각하면 제거해야 한다
                // 2. 조건문
//                if owner.count >= 3 {
//                    
//                    let vc = SecondViewController()
//                    owner.navigationController?.pushViewController(vc, animated: true)
//                }
            }
            .disposed(by: disposeBag)
    }
    
    
    deinit {
        print("First Deinit")
    }
}
