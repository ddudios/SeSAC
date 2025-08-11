import Foundation

class NumberViewModelRemind {
    
    // VC에서 VM로 들어오는 정보
//    var inputField: String? = "" {  // = ""
//        didSet {
//            print("inputField")
//            print(oldValue)
//            print(inputField)
//            validate()  // 호출
//        }
//    }
    var inputField = Field("")
    
    // VM에서 VC로 보내줄 최종 정보
//    var outputText = "" {  // 전달
//        didSet {
//            print("outputText")
//            print(oldValue)
//            print(outputText)
//            
//            closureText?()
//        }
//    }
    // 7. 글자 바뀌면 closureText 실행
    var outputText = Field("")
    // String을 갖고있는 Field타입으로 변경
    
    // 6. validate() 어디서 실행?
    init() {
        print("NumberViewModelRemind Init")
        
//        inputField.playAction {
//            self.validate()
        
        inputField.playAction { _ in
            self.validate()
        }
    }
    
    var outputColor = false {
        didSet {
            print("outputColor")
            print(oldValue)
            print(outputColor)
        }
    }
    
    var closureText: (() -> Void)?  // 글자 달라지면 실행
    var closureColor: (() -> Void)?
    
    
    // 일단 전체 코드 가져오기
    private func validate() {  // 변경
        //1) 옵셔널
        // String타입이기 때문에 필요없어짐
//        guard let text = inputField else {
//            outputText = ""
//            outputColor = false
//            return
//        }
        
        // 프로퍼티에 대한 지칭
        let text = inputField.value
        
        //2) Empty
        if text.isEmpty {
            outputText.value = "값을 입력해주세요"  // Field 클래스 내부의 text프로퍼티
            outputColor = false
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요"
            outputColor = false
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText.value = "₩" + result
            outputColor = true
        } else {
            outputText.value = "백만원 이하를 입력해주세요"
            outputColor = false
        }
    }
}
