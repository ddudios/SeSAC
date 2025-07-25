//
//  NicknameViewController.swift
//  SeSACWeek1Day2
//
//  Created by Suji Jang on 7/2/25.
//

import UIKit

class NicknameViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    
    // 공간에 고래밥을 집어넣는 거에 속도차이 -> String지정안하는데도 1이 제일 빠름
    // 선언, 초기화 방법이 다양한데 같은 속도가 아님
    // 컴퓨터가 자체적으로 1이 스트링타입이구나라고 알게하는 게 가장 빠름
    var nickname1 = "고래밥"
    var nickname2: String = "고래밥"
    var nickname3: String = .init("고래밥")  // 제네릭으로 다섯배정도 차이남(제일 느림)
    var nickname4: String = String(describing: "고래밥")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 1. 버튼 클릭 시 레이블에 "아무 내용" 보여주기
    // 2. 버튼 클릭 시 레이블에 "텍스트필드에 입력한 내용" 보여주기
    
    
    // 1. 읽어올 수 있는 프로퍼티, 쓸 수 있는 프로퍼티가 따로 나뉘어져 있다.
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        
        // 2. 옵셔널 타입인지 옵셔널 타입이 아닌지 확인해보기
        print(#function, nicknameTextField.text)
        
        // \() 문자열 보간은 무조건 값이 있어야만 함
        resultLabel.text = "아무 내용"  // nil일 수 없으니까 문제 없음
        resultLabel.text = "결과: \(nicknameTextField.text)"  // nil이면 어쩌려구?
        
        // 경고 해결
        resultLabel.text = "\(nicknameTextField.text ?? "")"
        resultLabel.text = "\(nicknameTextField.text!)"
        
        // 만약에 텍스트필드 값이 nil이면 어떡하지 -> ! 안쓰는게 맞긴함
        // text는 기본적으로 nil값을 가지고 있음
        
        resultLabel.text = nicknameTextField.text
        
        // 현재 버튼에 써있는 글자를 가져오는 기능
        checkButton.currentTitle
        
        // 3. 빈값이면 비어있어요라고 출력하기
        if nicknameTextField.text!.isEmpty {
            resultLabel.text = "비어있어요"
        } else {
            resultLabel.text = nicknameTextField.text
        }
        // 1. 공백 대응은? whitespace
        // 2. == "" 보다는 isEmpty
        // == 두 개를 비교하는 비교 연산자
        // isEmpty는 그냥 그것만 비어있는지 확인
    }
}
