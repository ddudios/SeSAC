//
//  TestViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Suji Jang on 7/16/25.
//

import UIKit

class TestViewController: UIViewController {

    // 글자가 무한히 길어지면 짤릴 수 있어서 중앙으로만 잡으면 오류가 생길 수 있음
        // 원래는 여백을 줘야 함
    @IBOutlet var nameLabel: UILabel!
    
    // 여기는 아웃렛이 만들어진 다음에 만들어짐
    // class는 모든 값이 초기화되어있어야 함
        // 뷰컨에서는 init만들지 않기
        // 초기화는 해야하기 때문에 옵셔널 또는 초기값 넣어주기
    //Pass Data 1. 데이터를 담을 공간을 생성
    var contents: String = "고래밥"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pass Data 3. 전달 받은 값을 뷰에 표현
        nameLabel.text = contents
    }
}
