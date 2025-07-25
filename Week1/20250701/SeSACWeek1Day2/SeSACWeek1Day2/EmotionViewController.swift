//
//  EmotionViewController.swift
//  SeSACWeek1Day2
//
//  Created by Suji Jang on 7/2/25.
//

import UIKit

class EmotionViewController: UIViewController {
    
    // Outlet Collection: 배열로 만들어주는 기능
    // 여러 개의 묶음을 하나의 이름으로 사용
    @IBOutlet var emotionLabel: [UILabel]!
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var thirdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        // for-in Vs. forEach
        // 같은 코드가 반복된다면 반복문을 통해서 해결할 수 있음
        for item in 0...2 {
            emotionLabel[item].textColor = .blue
        }
        
        for item in emotionLabel {
            item.backgroundColor = .yellow
        }
        
        // () 함수호출연산자
        designTextField(firstTextField, ph: "닉네임을 입력해보세요")
        designTextField(secondTextField, ph: "아이디를 입력해 보세요")
        designTextField(thirdTextField, ph: "비밀번호를 입력해 보세요", isSecure: true)
    }
    
    // 매개변수(Parameter)
    // 내부 매개변수
    // 왜부 매개변수
    // 매개변수 기본값
    func designTextField(_ textField: UITextField, ph placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.textColor = .brown
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = .bezel
//        textField.isSecureTextEntry = true  // 모든 텍스트필드가 true -> 매개변수로 전환
        textField.isSecureTextEntry = isSecure
    }
    
    func a() {
        
    }
    
    func a(nick: String) {
        
    }
    
    // @IBAction은 1:n 관계가 가능하다 (액션1-여러객체)
    // 함수호출 연산자가 있기 때문에 (   )
    // _ 외부매개변수 생략
    // sender는 내부 매개변수
    // 왜 Any가 아닌 UITextField를 선택해서 만들었냐: text를 확인하는데 Any면 text를 확인할 수 없다
    // 이벤트 발생시킨 택스트필드의 글자가 나온다
    @IBAction func didEndOnExit(_ sender: UITextField) {
        print(sender.text)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        print(#function)
        view.endEditing(true)
        // 화면에서 일어나는 모든 편집 작업을 끝내겠다 (커서 깜빡임을 끝내겠다)
        // 커서 시작일 때 키보드를 올리고, 커서가 꺼질 때 키보드를 내리도록 애플이 구성함
        // force: 강제로 끝낼건가? -> true
        // view는 애플이 View의 이름으로 정함
    }
}
