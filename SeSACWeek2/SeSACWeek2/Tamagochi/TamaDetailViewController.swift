//
//  TamaDetailViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/9/25.
//

import UIKit

class TamaDetailViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.backgroundColor = .blue
        
        // 커서를 띄웠는데 안보이게 하려면 .clear
        // 아예 안띄울 수는 없음
        nicknameTextField.tintColor = .clear
        nicknameTextField.placeholder = "닉네임을 입력해주세요."
    }
    
    // 항상 실행되는지 print문으로 디버깅하기
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
    // 안되면 구글링하는게 아니라 직접 해보기
    @IBAction func testButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
        // barbuttonitem이 IBAction은 동작하지만
        // unwind를 하면 동작하지 않는구나
        // button -> click -> touchUpInside (2가지가 연결되어 있으니까 하나가 안됨)
        // 어느 시점에 출력되는지 print로 확인하고
        // 어디서 이슈가 발생했는지
    }
    
}
