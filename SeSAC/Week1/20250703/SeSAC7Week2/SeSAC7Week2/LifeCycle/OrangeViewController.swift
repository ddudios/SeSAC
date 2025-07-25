//
//  OrangeViewController.swift
//  SeSAC7Week2
//
//  Created by Suji Jang on 7/3/25.
//

import UIKit

class OrangeViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    
    let list = ["고래밥", "칙촉", "카스타드", "몽쉘", "자갈치", "꼬북칩"]
    // 버튼을 클릭했을 때 다른 박스(메서드)에서 이 list를 사용하고 싶기 때문에 밖으로 빼냄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        // 이거는 이 박스(메서드)내에서만 사용 가능
//        let list = ["고래밥", "칙촉", "카스타드", "몽쉘", "자갈치", "꼬북칩"]
        let random = list.randomElement()
        print(random)
        resultLabel.text = random
        
        // 배열의 인덱스값과 맞추기 위해서 0, 1, 2로 맞춤
        oneButton.tag = 0
        twoButton.tag = 1
        threeButton.tag = 2
        
//        oneButton.setTitle("고래밥", for: .normal)
        twoButton.setTitle(list[1], for: .normal)
        threeButton.setTitle("카스타드", for: .normal)
        fourButton.setTitle("몽쉘", for: .normal)
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
    
    // Q. 하나의 액션으로 세개의 버튼을 클릭했을 때 레이블에 글자 바꾸기
    @IBAction func oneButtonClicked(_ sender: UIButton) {
        print(#function, sender.currentTitle)
        
        /*
        resultLabel.text = "고래밥"
        // 색깔 설정이 1000번 실행되지 않게 다른 곳에 위치시키는 게 좋겠다
        resultLabel.textColor = .brown
         */
        
        // 1.
        // 고래밥을 자갈치로 바꾸면? 두군데를 바꿔줘야 함
        // 조건문에 추가하지 않고 까먹을 수 있음 (문제 인식 시켜줘야 함 -> 보통 예외처리 esle문)
            // 추가한 버튼이 조건문에 없거나, 예외처리가 없을 때
//        if sender == oneButton {
//            resultLabel.text = "고래밥"
//        } else if sender == twoButton {
//            resultLabel.text = list[1]
//        } else if sender == threeButton {
//            resultLabel.text = "카스타드"
//        } else {
//            resultLabel.text = "이런 문제가 발생했어요"
//        }
        
        // 2. nil
        // 왜 조건문이 없어도 되는지 아는게 중요
        // 위의 조건문에 아래 코드를 넣어보니 전부 이 코드가 중복되니까 아래 코드로 대체될 수 있다
        // currentTitle: 직접 setTitle로 설정하지 않으면 nil
//        resultLabel.text = sender.currentTitle
        
        // 3.tag
        print(sender.tag)
        resultLabel.text = list[sender.tag]
    }
}
