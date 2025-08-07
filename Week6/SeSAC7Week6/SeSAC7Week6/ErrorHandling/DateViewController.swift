//
//  DateViewController.swift
//  SeSAC7Week6
//
//  Created by Suji Jang on 8/7/25.
//

import UIKit
import SnapKit

// Swift의 에러핸들링: 어떤 문제가 생기는지 열거형으로, 오류에 대한 명시
// Error프로토콜 채택하면 문제상황에 대한 대응이구나 커뮤니케이션적으로 좋음
// 컴파일러가 오류의 타입을 인정하게 된다
/// 오류 처리 패턴
enum BoxOfficeValidationError: Error {
    // 사용자의 취향 선택이 아닌 문제상황
    case emptyString  // 오류가 발생할 수 있는 상황 (Error인데 또 Error를 쓸필요X)
    case isNotInt
    case isNotDate
}

class DateViewController: UIViewController {
    
    let textField = UITextField()
    let button = UIButton()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        // Error채택하고 열거형을 활용하면 jack은 3가지 케이스로 나뉜다
        // enum으로 케이스를 나눴고 이게 에러를 지칭하는 것이라고 명세
        var jack = BoxOfficeValidationError.emptyString
        switch jack {
            // 그 외에 다른 케이스 활용하는 순간 빌드 전, 컴파일 순간에도 알 수 있다
        case .emptyString:
            <#code#>
        case .isNotInt:
            <#code#>
        case .isNotDate:
            <#code#>
        }
    }
    
    // 단순히 클릭시 텍스트 보임
    @objc func buttonClicked() {
        
        guard let text = textField.text else {
            print("텍스트필드 글자가 nil입니다")
            return
        }
        
        // 잘한 상황 외에 다 잘못한 상황이라고 하고 있다
        // error: Call can throw, but it is not marked with 'try' and the error is not handled
        //        if validateUserInput(text: text) {
        //            label.text = "검색이 가능합니다"
        //        } else {
        //            label.text = "검색을 할 수 없습니다"
        //        }
        
        /*
         1. enum error 3개를 모두 다 catch로 했는데도 catch { } 가 필요
         throw 3개 에러 던짐, BoxOfficeError 던짐(Swift Error프로토콜채택)
         2. boxOffice error 3개를 다 처리했더라도, AFError나 애플의 Error 등 다른 에러가 발생한다면? 들어갈 구석이 없음
         너네가 쓴 에러말고 다른 종류의 에러가 생기면 어디로 가야해? -> 떨이 처리 필요
         3. 귀찮더라도 try! try? 보다는 do try catch를 써보자
         4. new.. Swift6 Type Throws -> 다른 오류가 들어오지 않는 상황으로 제약을 줄 수 있다
         */
        
        // if-let, guard let구문할 줄 알면 ErrorHandling할 수 있음
        // return false 대신에 어디가 교체될 수 있는지
        // return false일 때 나는 알아볼 수 있지만, 사용자가 선택하는 건가?로도 볼 수 있었던 워딩인 반면에,
        // throw가 있으면 이건 명백하게 사용자가 하면 안되는 것을 알 수 있는 척도, 잘 됐을 때만 정상적으로 return해야한다
        // 선언부에 굳이 쓰는 것은 코드를 세세히 보지 않아도 함수 안에 오류를 리턴하는 기능들이 들어있다를 알기 위해서 명세
        
        // if-else는 잘했거나/못했거나가 아니라, 선택적인 상황이었던 것이다
        // 이제 validateUserInput은 잘한 상황 외에 나머지는 그렇게 하면 안되는 상황
        // 그러면 if-else대신에 do-try-catch구문 사용
        
        // if-else와 유사하지만(사용자의 선택적), false를 다양한 요소로 구성할 수 있다 - catch(사용자가 잘못한 상황)
        // 보통 catch 사용 형태: catch 너무 많으면 이상하니까 do try catch 조건문으로 구성
        // 기존 Swift
        
        do {  // 잘했을 때
            // try: 일단 시도해라
            let result = try validateUserInput(text: text)
            // 버전마다 다른 부분
            label.text = "검색이 가능합니다"
        } /*catch error {  // 잘못했을때
            
        }*/
        catch let error {  // 애플이 미리 만들어준 error 값: error상수를 만든 적이 없는데 사용할 수 있는게 catch문에서 error에 대한 상수를 애플이 내부적으로 만들어줌
            /*
             func validateUserInput(text: String) throws(BoxOfficeValidationError) -> Bool {
             라고 지칭을 해주면 내부에서 케이스로만 생략도 가능하고, switch구문에서도 error가 BoxOfficeValidationError라고 특정이 돼서 케이스 3개만 쓸 수 있다
             */
            switch error {  // 모든 에러를 다 받을 수 있는 상황이라서 생략도 불가능 -> throw타입을 뭘로 지정하냐에 따라서 세세하게 연결고리로 연결되어있던 코드가 조금씩 달라지는데 그냥 코드로 보고 짜면 눈에 안들어온다
                // 에러 타입에 대해서 비교해보면서 뭘 왜 써야하고 뭘 왜 안써도 되는지 구분
            case BoxOfficeValidationError.emptyString:
                <#code#>
            case BoxOfficeValidationError.isNotInt:
                <#code#>
            case BoxOfficeValidationError.isNotDate:
                <#code#>
            default:
                <#code#>
            }
        }
//    } catch BoxOfficeValidationError.emptyString {  // 잘못했을 때
//            // 이 상황에 받게 됨
//            label.text = "빈문자는 검색을 할 수 없습니다"
//        } catch BoxOfficeValidationError.isNotInt {  // 잘못했을 때
//            label.text = "문자열은 검색을 할 수 없습니다"
//        } catch BoxOfficeValidationError.isNotDate {  // 잘못했을 때
//            label.text = "날짜가 아니면 검색을 할 수 없습니다"
//        } //catch {  // 더이상 떨이 처리 X
//            // BoxOfficeValidationError외에 최종 떨이처리
//            label.text = "BoxOffice 에러가 아닌 다른 상황"
//        }
        
        // 사용자에게 잘못된 상황을 알리기만 하면 if-else, do-try catch 아무거나 상관없음
        // 개발자가 봤을 때 if-else면 약간의 분석이 필요하지만 do-try면 바로 에러상황에 대한 코드인지 바로 알 수 있다
        
        /*
        // throw -> do try catch
        // text기준으로 웬만하면 다 써야함
        // 귀찮다면 try(권장: 모든 캐치 다쓴 상황)/try?(권장X: 캐치가 발생할 수 있는 상황에 대해서 nil로 떨어짐)/try!(절대쓰지마라, 틀린상황 앱터짐)
        let result = try? validateUserInput(text: text)  // -> Bool?
        print(result)  // Error타입이 전달되는 것이 아니라 잘못된 상황은 nil
         */
    }
    
    // 조건이 많아지니까 조건을 판단하는 로직은 분리
    // 1. 사용자의 선택이 아니라 true빼고 나머지는 다 잘못했어! 라고 알려주고싶다
    // 2. false도 어떤 false인지 구체적으로 알고싶다! (버튼에 대한 결과 레이블로 봤을때 왜 검식이 안되는지 구체적인 사유를 알 수 없음)
    // 위 두가지를 해결하는 것이 에러핸들링
    
    // 에러를 발생할 수 있다는 걸 알리기 위해 throw 키워드를 선언
    // throw 키워드가 표시된 함수: throw function
        // 코드가 많을 때, 안에 throw function을 쓰고 있는지, return이 아닌 다른 키워드가 있는지/없는지 를 꼼꼼하게 코드를 보지 않아도 명시적으로 알려주고 싶다
        // return이 아닌 잘못된 상황에 대해서 throw를 쓰고싶다고 하면, 반환값 전에 throws 명세
        // 이게 하는 기능은 없고 단순히 Bool로 반환값이 있어와 같이, return말고 throw로 던져주는 게 있어를 알려주는 것
        // 내부는 하나의 오류를 던졌고 (throw) 이런 게 많이 있을 수 있으니까 밖에는 복수형throws으로 썼다
    
    // 이 내용 안에서는 아무리 찾아봐도 절대적으로 AFError등은 안생길거같은데.. Swift6 Type Throws
        // 제약: 에러를 특정 에러타입 안에서만 던질 수 있다고 지정할 수 있음 (AFError, Error 절대 안들어오니까 내 에러안에서만 핸들링)
    func validateUserInput(text: String) throws/*(BoxOfficeValidationError)*/ -> Bool {
        // validationError만 나올 것이다
        
        // 빈 값
        guard !(text.isEmpty) else {
            print("빈 값")
//            return false  // return 키워드는 정상적인 상황에서 함수를 끝내는 형태라고 하면, return이랑 같은건데 오류를 알려주기 위해서 조금 다른 키워드인 throw를 사용했다고 생각해도 됨
//            return BoxOfficeValidationError.emptyString  // 정상적 상황일 때 리턴 키워드와 비슷하게 사용
            throw BoxOfficeValidationError.emptyString  // 오류를 던져줄건데, 잘못된 상황일 때의 리턴 키워드라고 생각하면 쉬움
                // 빈값이 발생했을 때는 해당 케이스에 대해서 throw키워드를 이용해 에러를 던져주고 있다
                // false를 리턴해주는게 아니라, false에 구체적인 사유인 error중 empty다라고 던지는 거여서 이것과 같은게 return false
            // 그래서 실패하면 return이 끝나는것처럼 여기서 함수가 끝난다
            
            /* 어느 에러에서 나올 지 알 수 있기 때문에 축약해서 사용 가능
            throw .emptyString
             또한, 만일의 상황에서 발생할 수 있는 오류상황 때문에 catch { 떨이처리 }가 필요없어짐 -> 케이스 3개중에 3개만 쓰면 됨, 케이스에서도 Enum명 지우고 케이스만으로 축약해서 사용할 수 있음, 모든 케이스에 대해서 쓰지 않으면 떨이처리는 해주어야함
             */
        }
        
        // 입력한 값이 숫자인지 아닌지
        guard Int(text) != nil else {
            print("숫자가 아닙니다")
//            return false
            throw BoxOfficeValidationError.isNotInt
        }
        
        // 입력한 값이 날짜 형태로 변환되는지 아닌지
        guard checkDateFormat(text: text) else {
            print("숫자지만 날짜 형태가 아닙니다")
//            return false
            throw BoxOfficeValidationError.isNotDate  // throw가 있으면 사용자가 하면 안되는 행동을 했다는 명확한 척도가 될 수 있음
        }
        
        /*
        guard checkDateFormat(text: text) else {
            print("숫자지만 날짜 형태가 아닙니다")
            throw AFError.isNotDate
        }  // 어떤 로직이 있는지 세세하게 모르니까 애플이 기본적으로 제공하는 에러Error, 알라모파이어AFError -> 내가 만든 에러에서 모든 에러가 발생하지 않을 수 있음*/
        
        return true  // 모두 잘 됐다면 return
    }
    
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format.date(from: text) == nil ? false : true
    }
    
    func configure() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(label)
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(button.snp.bottom).offset(20)
        }
        
        button.backgroundColor = .red
        button.setTitle("클릭", for: .normal)
        
        label.backgroundColor = .yellow
        label.text = "레이블"
        
        textField.placeholder = "텍스트필드"
    }
}
