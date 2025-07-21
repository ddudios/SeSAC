//
//  YellowViewController.swift
//  SeSAC7Week2
//
//  Created by Suji Jang on 7/3/25.
//

import UIKit

class YellowViewController: UIViewController {
    
//    let nickname = "고래밥"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        let nickname = "칙촉"  // scope: 가까운 순서
        print(nickname)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self, #function)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        print(self, #function, nickname)
    }
}
