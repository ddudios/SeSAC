//
//  ViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/21/25.
//

import UIKit

struct BMI {
    static var name = "고래밥"  // 절대 안바뀌는 부분에 대해서는 static으로 관리: 한공간에 저장되냐(선언해도 static은 한 공간에 생겨서 호출해서 사용) / 썼다지웠다 반복하냐(선언마다 공간생김)로 구분)
    let height: Double  // 인스턴스 프로퍼티, 저장 프로퍼티
    let weight: Double
    
    // 계산도 VC가 아닌 너가 해라
    func resultFunc() -> String {
        let value = weight / (height * height)
        if value < 18.5 {
            return("저체중")
        } else {
            return("정상 이상입니다")
        }
    }
    // 연산프로퍼티를 모를 땐 반환값이 있는 함수로 만든 다음에 변형
        // 프로퍼티이기 때문에 let/var, 연산프로퍼티는 var만 사용 가능
        // 저장프로퍼티에 들어있는 값에 따라서 내뱉는 내용이 달라지니까 정해진 데이터라고 볼 수 없으니까, 항상 연산을 하게 되면 최종적으로 내뱉는 결과가 달라지기 때문에 그런 것들을 생각하면 var로 쓸 수밖에 없다
    //  주로 저장프로퍼티를 통해 연산(get, set 구문)을 한다 (저장프로퍼티가 없어도 상관 없다)
    // 연산프로퍼티는 통로같은 것으로, 계산해서 최종적인 결과를 뷰컨에서 쓸 수 있다 정도로 볼 수 있어서 직접적으로 자기가 공간을 차지하고 있지 않다
    // 함수 대신 연산을 하는 수단으로, 매개변수가 필요 없다면 연산 프로퍼티를 사용할 수 있다
    // 저장프로퍼티를 통해서 계산한 최종 결과를 외부로 가져다 주는 상태: get (만 쓰면 get 생략 가능)
        // get을 set보다 많이 사용 -> set을 안 쓴다면 get중괄호는 생략해도 된다
    var result: String {
        get {  // String을 가져다 줄게
            let value = weight / (height * height)
            if value < 18.5 {
                return("저체중")
            } else {
                return("정상 이상입니다")
            }
        }
        set {
            // 연산을 통해서 타입프로퍼티 값 변경 (그냥 name으로는 접근불가능)
            BMI.name = newValue
        }
    }
    /*
     struct SwiftUiView: View {
        var body: Some View {
            // 등호가 아니고 중괄호로 되어있기 때문에 SwiftUI에서 이것도 연산 프로퍼티
            get {
            }
        }
     }*/
}

class ViewController: UIViewController {

    @IBOutlet var height: NSLayoutConstraint!
//    @IBOutlet var heightTextField: UITextField?  // 여기가 물음표일리는 없다
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var goButton: UIButton!
    
    var bmi = BMI(height: 1.8, weight: 60)  // 선언때마다 공간이 생김
    
    // Swift5.7+ if let shorthand
    var nickname: String?
    var age: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = nickname, let myAge = age {}
        // 변수명을 다르게 쓰는게 일반적인 형태이지만, 매번 새로운 이름을 짓기 힘드니까 if let 내부에서만 변수를 사용할 수 있기 때문에 같은 이름으로 해결
        if let nickname = nickname, let age = age {}
        if let nickname, let age {}  // if let shorthand: 같은 이름으로 사용한다면 축약형으로 사용 가능
        // 댑스가 들어가면 사용할 수 없음(변수명으로 textField.text를 쓸 수 없음) => 간단한 프로퍼티명, 간단한 자료형 등에서만 사용 가능한 형태
        
        // 반복되고 쓰기 좀 귀찮으니까 개선
//        UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        let a = UserDefaults.standard.string(forKey: "name")
        var ud = UserDefaultsHelper()
        print(ud.name)  // UserDefaults사물함에 들어있는 name을 갖고오고 싶으면 사물함에서 이것저것 다 가져올 수 있기 때문에 코드가 짧아진다
        // VC에서 UserDefaults코드를 써도 된다 그러면 이 코드를 통해서 UserDefaults까지 가서 이 사물함에서 name이라는 내용을 찾아서 꺼내서 가져오는 과정이 뷰컨을 통해서 일어난다고 하면, 지금은 중간 단계가 하나 더 있는 것이다
        // 뷰컨에서 직접적으로 사물함을 호출하는 것이 아니라, 뷰컨트롤러에 UserDefaults헬퍼가 사물함 가서 내용을 가져와서 뷰컨에게 주고 있는 행위를 진행중
        print(ud.test)
        // 어쩌피 사물함에 있는 내용 가져와서 담아서 쓰는 건데, 보기에는 똑같은데 왜 연산을 써야하지?
            // 직접 UserDefaults에 저장하고 꺼내보면 내용이 달라지는 것을 확인할 수 있음
            // 뷰컨에 헬퍼공간이 만들어질 때 UserDefaults()인스턴스 생성, 이 인스턴스를 생성할 때 그 당시 사물함 정보를 가져와 test는 저장을 해서 담아두고 끝남
            // 그런데 name은 매번 사물함을 거침, 처음 사물함 내용을 가져오는 것은 가능한데 변경된 내용을 가져오는 것이 test는 불가능하다
            // name은 통로여서 뷰컨에서 프로퍼티를 호출하면 연산프로퍼티는 계속 사물함을 거치니까 name이 바뀌는 것을 바로바로 가져올 수 있다
        print(ud.age)  // 아직 아무 내용도 넣어주지 않아서 손님, 0이 나온다
        
        UserDefaults.standard.set(100, forKey: "age")
        UserDefaults.standard.set("이름", forKey: "name")
        print(ud.name)
        print(ud.age)  // get: 등호 없으면 가져오는 것
        
        ud.name = "Jack"  // set: 등호 있으면 값을 넣어주는 것
        ud.age = 345  // 값을 들고 들어와서 셋팅을 해주면 되겠네
        print(ud.name)
        print(ud.age)
        
        /*
        let user = User()
        // init기능이 안쓰더라도 호출해서 자동으로 사용할 수 있음, 여기서 이니셜라이저 구문을 실행해서 인스턴스 생성
//        let mentor = Mentor()
        let mentor = Mentor(name: <#T##String#>, age: <#T##Int#>)*/
        
        
        goButton.addTarget(self, action: #selector(goButtonClicked), for: .touchUpInside)
        
        // Function Type Preview: 어떤 매개변수, 어떤 반환값을 갖는 지에 따라 다양한 타입이 나올 수 있다
            // 함수 실행시 goButtonClicked() 함수 호출 - 함수 호출 연산자()
            // selector는 함수의 이름만 쓰면서, 함수의 이름과 실행을 별개로 가져가려고 한다
            // Type: var nick = "고래밥" //String Type
                    // var a = 30 // Int Type
            // 함수를 실행하지 않고 함수 기능만 넣어준 것
        
        let a = jack
        print(a)  // 함수 호출 연산자를 활용해 실행하면 String타입
                    // 함수의 기능과 실행을 별개로 나누어서 처리하는 것도 가능하다 (Swift)
        a()
        
        let b = jack()  // 함수를 실행하고 난 결과를 담아서 String 타입
        let c: () -> String = jack  // 함수를 실행하지 않고 함수 내용만 담은 상태
        
        // 함수 타입이 같다면 바꿔치기도 가능
        var e = jack
        e = den
        
        // 다 담을 때 오류가 나지 않았는데 이건 오류
            // 같은 함수 이름이 여러개
            // 둘 중에 뭘 담아야할 지 모름 -> 타입 어노테이션으로 명시해 인지할 수 있게 만든다
        let f: () -> Int = finn
            // 또는 아무것도 넣지 않은 채로 함수명명
        let g = finn(a:)
        
//        JackImage(systemImage: <#T##String#>)
    }
    
    // 매개변수는 없고 반환값은 String을 반환하는 함수
    // 실행하고 무언가를 던져주는 반환값이 있는데 어디에도 안 쓸거야?
    func jack() -> String {
        print("=")
        return "안녕하세요"
    }
    
    // 함수를 실행하고 나면 끝
    @objc func goButtonClicked() {
        /*
        // 화면 전환: 스토리보드에 ResultViewController가 있다면 present
        // 스토리보드에 더이상 ResultViewController가 없어서 오류
//        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
//        let vc = ResultViewController()
        // 클래스 다룰 때도 인스턴스를 만들 때 인스턴스 생성을 위해서 ()를 만들었는데, ResultViewController도 클래스이기 때문에 인스턴스로 공간을 만들어서 전환할 것이기 때문에 가져오는 방식이 이름만 ViewController이지 사실상 같은 맥락
        // vc의 타입과 vc2의 타입이 같음: ResultViewController
        // 만약 스토리보드가 있다면 오류: 씬, 로직 연결, 아웃렛도 가져와야하는데 그것들을 안가져오기 때문에 앱이 터짐
        
//        present(vc, animated: true)
        
        // ()는 실행시점과 비슷하게 볼 수 있는데
            // goBUttonClicked() 함수 호출 연산자 - 괄호의 유무 차이는 함수의 실행을 도와줌
            // ResultViewController() 메서드의 일종이기는 한데, init이 숨어있다
            // 함수를 호출해주는 연산자가 있고 인스턴스를 생성해주는 연산자가 있고 이게 init구문이구나
        
        /*
        // textField가 확실하지 않기 때문에 자동으로 ?.가 붙는다
        print(weightTextField?.text?.count)
        // 옵셔널 체이닝을 풀어서 쓰면,
        if weightTextField != nil {
            if weightTextField!.text != nil {
                weightTextField!.text!.count
            }
        }*/
        
        
//        let weight = weightTextField.text  // text가 옵셔널이어도 nil이 절대 출력되지 않으니까 !여도 되기 때문에 빠르게 개발해야할 때는 사용해도 된다
//        let height = heightTextField.text
        
        // 한 번에 여러개의 옵셔널을 해제할 수 있다
        /*
        if 참 { 실행 } else { 나머지 }
         guard 참 { 나머지 } (나머지에 해당하는 부분이 먼저 실행됨, 참에 해당하는 부분은 밖으로 나온다)
         
         *//*
        if let weight = weightTextField.text,
           let height = heightTextField.text {  // String? -> String: weightTextField.text가 weight에 담긴다면 옵셔널이 아니다
            print(weight.count, height.count)  // 더이상 nil값이 있을 가능성이 없음
            // (참) weight, height은 중괄호 안에서만 사용 가능
        } else {  // nil이면 else문으로 떨어짐
            print("weight TextField, height TextField가 nil인 상황")
        }
        // ==
        if weightTextField.text != nil,
            heightTextField.text != nil {
            print(weightTextField.text?.count ?? 0)
        } else {
            
        }
        // ==
        guard let weight = weightTextField,
              let height = heightTextField else {
            print("weight TextField, height TextField가 nil인 상황")
            return  // early exit
        }
        // 통과 (weight, height 중괄호 안이 아닌 바깥에서 사용 가능 -> if let 대비 활용할 수 있는 범주가 메서드 안으로 넓어짐)
        */
        /*
        let result = Double(weight ?? "0")  // 1. weight nil - 예외처리로 해결: weight이 nil이 들어갈 수 있는데 nil을 Double로 변환할 수 없기 때문에 nild이면 대신 나올 것을 써줌 -> 2. double nil - 막상 확인해보면 result도 옵셔널: 문자열 등은 Double로 변환 불가능
        print(result ?? "error")  // 모든 라인을 쓸 때마다 옵셔널 경고가 뜬다
         */
        
        // heightTextField: 2글자 이상 써야 계산 진행
//        let height = heightTextField.text
//        if (height?.count ?? 0) > 2 {} else {}
        /*
        if let height = heightTextField.text, height.count > 2 {  // nil이면 else, 아니면 height.count에 사용됨 -> 2보다 큰지 조건문 판단
            print(height)
        } else {
            print("키 텍스트필드가 2글자 미만입니다.")
        }
        if let weight = weightTextField.text, weight.count > 2 {
            print(weight)
        } else {
            print("몸무게 텍스트필드가 2글자 미만입니다.")
        }
            // 둘 중 하나가 안되더라도 어떤 텍스트필드가 잘못되었는지 특정할 수 있음 (키는 충족해도 몸무게는 충족하지 않을 수 있다)
            // height, weight 두 변수가 쓸 수 있는 범위가 다름 (키는 위의 블럭에서만 사용 가능하고, 몸무게는 아래에서만 사용 가능해서, 둘을 연산할 수는 없다 -> 한 공간에 써줘야 연산 가능하지만 합쳐버리면 둘 중 어느 것이 문제인지 알 수 없음)*/
        
        // guard 주의사항: print를 꼭 써보자
            // 버튼 눌렀는데 왜 아무일도 안일어나지? else의 return에서 끝나버리니까 뒤의 Print가 실행되지 않으니까
            // 동작시점에 익숙하지 않을 때는 print로 뭐라도 찍히는지 항상 확인해야 한다
        guard let height = heightTextField.text, height.count > 2 else {
            print("키 텍스트필드가 2글자 미만입니다.")
            return
        }
        guard let weight = weightTextField.text, weight.count > 2 else {
            print("몸무게 텍스트필드가 2글자 미만입니다.")
            return
        }
            // 범위 밖에서 변수를 사용할 수 있으니까 연산 가능
            // 뒤의 코드가 조건을 충족해도 앞의 코드가 조건을 충족하지 못하면 뒤의 구문은 실행되지 않는다
        print("키", height)
        
        /*
        print(BMI.self.name)  // BMI 나 자체를 통해서 이름을 꺼내옴 static
        print(bmi.height, bmi.weight)
        let result = bmi.weight / (bmi.height * bmi.height)
        if result < 18.5 {
            print("저체중")
        } else {
            print("정상 이상입니다")
        }
        // - VC: present만 해주는건데, 조건문 판단, bmi계산도 해야하니?
            // BMI에서 굳이 키, 몸무게를 꺼내와서 연산 -> 이때 연산프로퍼티 사용 가능
         */
        // - BMI: 에서 계산하면 여기서 할 필요 없음
        print(bmi.resultFunc())  // 굳이 매개변수가 필요없을 거 같으니 함수일 필요가 없을것 같으니 연산 프로퍼티를 활용해볼 수 있다
        
        bmi.result = "sesac"
        print(BMI.name)
         */
        let vc = MarketViewController()
        present(vc, animated: true)
    }
    
    // #selector - 이름만 적더라도 찾을 수 있던 이유
    // 코드를 쓰다보면 함수 이름이 겹칠 수 있다 -> 구별할 수단이 없으니까 오류
    // 함수 타입이 다르기 때문에 문제가 생김 -> 펑션타입이 메서드 하나면 특정할 수 있음
    // 못찾으니까 같은 이름 쓰지 말기, Function Type에 대한 의미
//    func goButtonClicked() {
//        
//    }
    
    func finn() -> Int {  // Function Type: () -> Int
        return 10
    }
    
    func finn(a: Int) -> Int {  // Function Type: (Int) -> Int
        return a * 2
    }
    
    func den() -> String {  // Function Type: () -> String
        return "저는 Den입니다"
    }
    
    let d = den
    // 함수를 실행하지 않고 이름만 담아보면 어떤 형태로 정의되어 있는지 확인할 수 있음
}

// 클래스 안에 아무것도 들어있지 않아도 활용(Empty())가능
class Empty {
    
}

class User {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct Mentor {
    let name: String
    let age: Int
    
    // 눈에 보이지 않지만 자동으로 생성해줘서 초기화를 해주는 init() 기능이 있음
        // init()을 써야 활용(Mentor())할 수 있는 것이 아니라 init을 안써도 호출해서 사용할 수 있고 이때의 ()는 인스턴스를 만든다는 init(){}기능이 숨어있다
        // class/struct 호출하고 ()를 활용하는 것은 initializer구문을 실행하는 것이다
    
    // initializer구문을 안써도 자동으로 만들어주지만
    // 나이만 따로 받고 이름은 고래밥으로 받아야지
    // 초기화는 개발자 마음대로 가능
    init(age: Int) {
        self.name = "고래밥"
        self.age = age
    }
    
    init() {
        self.name = "손님"
        self.age = 13
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    // Mentor구조체가 초기화되기 위해서는 가지고있는 모든 프로퍼티가 초기화되어야 하고
    // 모든 프로퍼티들이 초기화되기 위해서 3가지 방법을 지원해주고 있는 것
}

//class JackImage {
//    var image: String  // 이미지를 로드할 수 있는 공간
//    
//    init(image: String) {
//        self.image = image
//    }
//    
//    init(systemImage: String) {
//        
//    }
//    
//    init(asdf: String) {
//        
//    }
//}
