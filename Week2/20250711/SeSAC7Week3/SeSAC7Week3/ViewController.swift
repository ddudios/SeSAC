//
//  ViewController.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/11/25.
//

import UIKit
import Toast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(0)
        print(3)
        print(5)
        print(6)
        print(7)
        print(8)
        
        view.backgroundColor = .darkGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.makeToast("안녕하세요 반갑습니다", duration: 2, position: .top)
    }
}

