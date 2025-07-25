//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var randomLabel: UILabel!
    
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    
    
    // 2. 위치
//    let list = ["고래밥", "초코하임", "호올스", "칙촉"]

    // 3. 변수명
    let sender: [String] = ["ㅇㅁㄹㄴ", "ㅁㅇㄹ"]
    
    // 뷰디드로드 직전에 실행
//    override func loadView() {
//        <#code#>
//    }
    
    // class 안은 모두 초기화가 되어 있어야 한다
    let nickname: String = ""  // 선언만 (nickname이라는 공간은 있는데 아무것도 없음)

    
    // 아웃렛 로드(Label이 만들어지는 중): 아직 다 만들어지지 않은 상태에서 Label의 text를 가져와라고 하면 가져올 수 없음
    // 동시에 일어나는 것처럼 보이지만 순서가 있다
    // viewDidLoad시점 이후부터 아웃렛을 사용할 수 있다
//    let text = randomLabel.text
    
    
    // 화면이 뜨자마자 닉네임 추천 레이블이 뜨려면
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = "닉네임"
        self.randomLabel.text = "닉네임 추천"
        self.randomButton.setTitle(name, for: .normal)
        
        if randomButton == nil {
            
//        randomBtton!
        } else {
            randomButton!.setTitle("name", for: .normal)
        }
        
        /* self의 종류 비교 (이런 내용 명확히 알기)
        self.blueButton
        Self
        String.self
         */
        
        /*
        for (let) item in sender {
            print(item)
            
            // item은 내부적으로 상수로 되어있기 때문에 바꿀 수 없다
//            item = "Jack"
        }
         */
        
        let nick = "고래밥"  // 선언+초기화
        randomLabel.text = nick
        
//        let nickname: String  // 선언
//        nickname = "고래밥"
        randomLabel.text = nickname
        // 선언과 초기화를 따로할 수 있지만, 사용하려면 초기화는 해야한다
        
        // 1. 왜 옵셔널이 필요한가
        // 2. !
//        let age = "2ㅇㅁㄹ2"
//        let next = Int(age)! + 1
//        print(next)
        
        // @IBAction도 실행 가능
        randomButtonTapped(randomButton)
        blueButtonTapped(blueButton)
        
        
        // 저장된 데이터 꺼내오기 (가져올 때는 타입이 중요, 저장할 때는 타입 상관없음)
        // => 영구적인 공간에 저장되어 있음
        // Int값으로 저장한 것은 age니까 짝꿍을 맞춰줘야 함 (주머니에 값이 있다면 Int로 꺼내줘)
        print(UserDefaults.standard.integer(forKey: "age"))
        
        // 문자열을 가져올 때는 string주머니를 꺼내야 함
        // 주머니의 대소문자 구분해야 함
        print(UserDefaults.standard.string(forKey: "Nick"))
        
        phoneTextField.text = UserDefaults.standard.string(forKey: "Nick")
        
        // 존재하지 않는 키로 조회
        print(UserDefaults.standard.bool(forKey: "den"))  // false
        print(UserDefaults.standard.integer(forKey: "hue"))  // 0
        print(UserDefaults.standard.string(forKey: "jack"))  // nil
        // 존재하지 않는다면 false, 0, nil(한글로줘야할지,.. 등등 몰라서)을 default로 줌
    }

    @IBAction func randomButtonTapped(_ sender: UIButton) {
        
        // 1.
        let list = ["고래밥", "초코하임", "호올스", "칙촉"]
        let result = list.randomElement()
        randomLabel.text = result
    }
    
    @IBAction func blueButtonTapped(_ sender: UIButton) {
//        blueLabel.text = list.randomElement()
        
        // 애플의 이름을 웬만하면 안쓰는게 충돌을 피할 수 있다
        // 가까운 것을 가져오니까 sender는 UIButton타입이 됐고 그 안에는 randomElement()가 없어서 오류
        blueLabel.text = self.sender.randomElement()
    }
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        // 숫자인지 아닌지 확인
        var nick: String? = "고래밥"
        
        let value = phoneTextField.text!
        // !
        // ?? "010"
        
        if Int(value) == nil {  // 숫자로 못바꿈
            print("숫자가 아닙니다")
        } else {
            print("숫자입니다")
            print(Int(value))
            randomLabel.text = "\( Int(value) )"
        }
    }
    
    @IBAction func alertButtonClicked(_ sender: UIButton) {
        /*
        // 1. 바탕
        let alert = UIAlertController(title: "BMI 결과", message: "당신은 정상 체중입니다.", preferredStyle: .alert)
        // 공백 Vs. nil
        
        // 2. 버튼
        let ok = UIAlertAction(title: "OK", style: .default)
        let ok2 = UIAlertAction(title: "OK2", style: .destructive)
        let ok3 = UIAlertAction(title: "OK3", style: .default)
        let ok4 = UIAlertAction(title: "OK4", style: .cancel)
        
        // 3. 바탕+버튼
        // addAction 순서대로 붙음
        alert.addAction(ok)
        alert.addAction(ok4)
        alert.addAction(ok2)
        alert.addAction(ok3)

        // 4. 띄우기
        present(alert, animated: true)
         */
        
        // 실제 앱 용량에 저장
        // 앱 껐다 키더라도 유지
        // Dictionary로 이해 (내용, 어떤 키에 저장)
        UserDefaults.standard.set(phoneTextField.text!, forKey: "Nick")
        UserDefaults.standard.set(40, forKey: "age")
    }
}

