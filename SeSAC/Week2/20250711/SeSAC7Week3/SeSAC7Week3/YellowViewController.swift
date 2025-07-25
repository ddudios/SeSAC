//
//  YellowViewController.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

class YellowViewController: UIViewController {

    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        // 1. 어떤 스토리보드에서 2. 어떤 뷰컨트롤러로 3. 사라지게 만들지
        // 하지만 => 어느 화면에서 온지 기록되어 있다 (어디로 사라질지 이미 앞의 화면에서 알고 있기 때문)
        dismiss(animated: true)
    }
}
