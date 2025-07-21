//
//  ViewController.swift
//  SeSAC7Week2
//
//  Created by Suji Jang on 7/3/25.
//

import UIKit

class ViewController: UIViewController {
    
    // 키보드 내리는 방법
    // 1. exit (return)
    // 2. button 클릭
    // 3.
    
    

    // 뷰컨트롤러 생명주기 중 하나
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        view.backgroundColor = .red
        
//        view.isUserInteractionEnabled = false
    }
    
    // 생명주기+
    // WWDC24+ 등장17+ 적용가능iOS13+
    // 동적으로 핸들링할 때 도움
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
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
        print(self, #function)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
        
//        sender.currentTitle // sender가 버튼이어야 사용 가능
    }
    
    @IBAction func myImageTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
}

