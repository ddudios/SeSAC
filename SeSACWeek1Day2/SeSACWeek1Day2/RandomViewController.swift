//
//  RandomViewController.swift
//  SeSACWeek1Day2
//
//  Created by Suji Jang on 7/1/25.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    // 스토리보드와 연결되어 있다 IBOutlet
    
    @IBOutlet var checkButton: UIButton!
    // 화면에서 이름이 위에 있어야 찾기 쉬움
    // 코드는 큰곳에서 작은곳으로 들어가는 건 쉬운데 작은곳에서 큰곳으로 가는 건 어렵기 때문에 이 위치
    
    @IBOutlet var userTextField: UITextField!
    
    var nickname = "고래밥"
    
    // 사용자 눈에 보이기 직전에 실행되는 기능
    // 모서리 둥글기, 그림자 등 속성을 미리 설정할 때 사용 (완성 후 사용자에게 보여줘야 한다)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        designCheckButtonUI()
        
        nickname = "칙촉"  // String타입
        resultLabel.backgroundColor = UIColor.yellow  // numberLaabel은 워낙 많기 때문에 어떤 것을 사용할지 지정해줘야 함
        resultLabel.textColor = .green
        resultLabel.text = "안녕하세요"
        resultLabel.numberOfLines = 2
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.textAlignment = NSTextAlignment.center
        resultLabel.alpha = 0.8
        
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 3
        resultLabel.layer.borderColor = UIColor.red.cgColor
        // 타입이 달라서 .red로 사용 불가능
        // UIColor -> CGColor로 변경
        resultLabel.clipsToBounds = true  // 기본값은 false (체크박스 해제)
        
        userTextField.placeholder = "닉네임을 입력해보세요"
        userTextField.keyboardType = .emailAddress
        userTextField.borderStyle = .bezel
        userTextField.isSecureTextEntry = true
    }
    
    // 실행하지 않으면 디자인이 적용되지 않음
    func designCheckButtonUI() {
        checkButton.layer.cornerRadius = 50
        checkButton.layer.borderWidth = 5
        checkButton.layer.borderColor = UIColor.black.cgColor
        
        checkButton.setTitle("눌러보세요", for: .normal)
        checkButton.setTitleColor(.black, for: .normal)
        checkButton.setTitle("빨리", for: .highlighted)
        checkButton.setTitleColor(.red, for: .highlighted)
        checkButton.backgroundColor = .yellow
    }
    
    // Touch Up Inside
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        print("버튼이 클릭되었습니다.")
        resultLabel.text = "고래밥 \(Int.random(in: 1...19000))"
    }
    
    // 텍스트필드 글자가 바뀔때마다 실행 (실시간 글자 감지)
    @IBAction func userTextFieldEditingChanged(_ sender: UITextField) {
        print("이게뭐지")
        print(userTextField.text)
    }
    
    // '키보드에서 Return키를 누르면 키보드가 내려감'의 기능까지 가지고 있음
    @IBAction func userTextFieldDidEndOnExit(_ sender: UITextField) {
        print("항상 프린트로 먼저 확인해보기: DidEndOnExit이 뭘까")
    }
    
}
