import UIKit

// 함수(function)
    // 이름 있는 함수: func hello() {}
    // 이름 없는 함수: 클로저 (함수 중에서 이름이 없는 것을 클로저라고 본다)

// 함수 선언
func hi() -> String {
    return "안녕하세요"
}

// 함수 사용(실행): 함수이름(함수호출연산자)
hi()


// 이름이 없다는 의미: {함수 내용}()
    // View에서 객체를 만들 때 사용했었음: 실행 결과를 객체에 담았었다 (클로저의 일종)
    // 이렇게 사용할 수 있는 이유: 일급 객체(First Class Object)
        // 일급 객체 특성을 스위프트 언어가 갖고 있기 때문에 클로저가 있을 수 있다
        // 영국에서 일급시민, 이급시민은 투표할 수 있는 권리 등
            // 가질 수 있는 권한 자체가 일급시민이 많았다 -> 여기서 온 것이 일급객체
            // 그래서 다른 객체보다 많은 기능을 가지고 있어서 Swift 언어에는 일급 객체의 특성이 있고, 이 일급 객체의 특성을 함수가 가지고 있기 때문에 Closure에 대한 개념도 이 골자에서 이해하면 된다

// 일급 객체 특성
// 1. 변수나 상수에 함수를 저장할 수 있다
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? true : false
}

// 상수에 함수를 저장한 것 아닌가?
// 이 코드는 함수가 실행이 되고 그 반환값인 Bool이 jack에 저장된 것
    // 함수가 아닌 함수가 실행되어서 반환된 Bool값을 저장한 것
let jack = checkBankInformation(bank: "대구")
print(jack)  // return했기 때문에 print하지 않으면 디버그 영역에 뜨지 않음

// 함수 호출 연산자인 ()를 쓰지 않는 것
// (String) -> (Bool) 타입의 함수가 담겨있음
// 함수만 상수에 담은 것으로, 실행은 아직 안됨
// 일급 객체는 변수/상수에 함수 자체를 대입할 수 있다
let account = checkBankInformation
let result = account("신한")  // 상수를 실행하는 것처럼 보이지만, 상수와 함수가 같은 것이라서 함수를 실행하는 것과 같은 것이다
print(result)

func average(a: Int, b: Int) -> Int {
    return (a + b) / 2
}

// 함수 실행 반환값을 담은 거라서 일급객체특성을 보여주는 것은 아님
let value = average(a: 3, b: 5)
print("평균 \(value)점 입니다.")

let functionType = average  // 담기기만 한거지 아직 실행되지 않음
print("이 평균은 \(functionType(20, 40))입니다.")  // 매개변수를 담아서 상수를 실행하고 있다: 함수 자체가 담겨있기 때문에 일급객체의 특성을 사용
// 함수를 상수에 담아서 (Int, Int) -> Int 상수의 타입을 확인하면 함수가 담겨있는 것을 볼 수 있다


// 2. 매개변수에 함수를 사용할 수 있다.
// (String) -> String
func hello(name: String) -> String {
    return "저는 \(name)입니다."
}

// (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

// () -> Void
func hello() {
    print("안녕하세요")
}

// 셋 중에 뭘 넣을 지 모를 때 Function Type 사용
let a: () -> Void = hello  // 유일해서 특정 가능
//let b: (String) -> String = hello  // Function Type이 같으면 타입어노테이션으로도 해결 불가능
let b: (String) -> String = hello(name:)  // 명확하게 매개변수가 들어간 상태에서는 타입어노테이션이 필요없다 -> 특정만 가능하면 된다
let c = hello(username:)  // 함수 표기법으로, 함수가 실행된 건 아님
c("jack")  // 왜 매개변수명이 필요없을까? 함수 표기법으로 명확하게 선언되어 있다면, 매개변수 명칭이 무엇인지 알 수 있어서 상수 실행시 매개변수명이 빠져도 된다
// .addTarget도 Function Type이자 일급객체 특성을 갖고 있어서 #selector()에서 사용 가능

// () -> ()
func oddNumber() {
    print("홀수입니다.")
//    return  // 모든 메서드에는 return이 숨어져있고 반환값이 없을 때는 생략해서 쓴다
}

// () -> ()
func evenNumber() {
    print("짝수입니다.")
}

// 지금까지는 매개변수에 Int, Array, Class 등이 들어가는 형태였는데 함수 그 자체를 넣어보려고 한다
func calculateNumber(number: Int, odd: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : odd()
    // 나누어 떨어지면 even(실행)
    // 상황에 따라 실행하는 함수를 다르게 만듦
    // 반환값이 없기 때문에 (Void) return을 쓰고 있더라도 실질적으로 내뱉는 것이 없는 상태라서 return 키워드 사용해도 된다
    
    if number.isMultiple(of: 2) {
        print("짝수입니다.")
    } else {
        print("홀수입니다.")
    }
}

// 매개변수에 함수가 들어갈 수 있다
// 타입만 일치하면 어떤 함수든 넣을 수 있다
calculateNumber(number: 44, odd: hello, even: evenNumber)

// Swift에서 제공하는 클로저의 축약 형태
// Int는 그냥 넣으면 되는데, 이름 없는 함수를 넣고 싶음
// 매번 이름 짓기 싫어서 이름없이 함수 내용 자체만 만들어주고 싶다
calculateNumber(number: 44) {
    print("홀수입니다.")
} even: {
    print("짝수입니다.")
}
/*
// ex. SnapKit
titleLabel.snp.makeConstraints { make in
    make.top.equalToSuperView()
}

// ex. UIAlertAction
let action = UIAlertAction(title: <#T##String?#>, style: <#T##UIAlertAction.Style#>, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)*/


// 클로저 표현식
// 이름 없는 함수를 어떻게 쓸까
// () -> Void
func study() {
    print("iOS 개발자를 위해 열공중")
}

let studyHard = study  // 상수에 함수 자체를 담을 수 있다
let studyHard1 = {  // == 이름이 들어가는 게 아니라 익명 함수로서 내용만 넣어줄 수 있다
    print("iOS 개발자를 위해 열공중")
}
// in에 대해서 (11:15)
// 클로저 헤더 in 클로저 바디
// () -> Void는 생략 가능
// 상수/변수에 함수 담기
let studyHard2 = { () -> Void in
    print("iOS 개발자를 위해 열공중")
}

// 매개변수에 함수 담기
// () -> Void 타입의 함수는 매개변수로 다 들어올 수 있게 만듦
func studyWithMe(study: () -> Void) {
    study()
}

studyWithMe(study: studyHard2)

// 인라인 클로저
    // 매개변수도 작성이 되어 있고, {함수가 들어가는 것도 알 수 있고}, 함수 안에 무슨 타입인지도 정의되어 있어서,
    // 클로저의 헤더와 바디가 다 들어가고 매개변수까지 싹 다 나와있고 (함수의 실행과 끝 사이에 {함수 형태가 그대로} 들어와 있는) 것을
    // 클로저를 표현할 수 있는 방식 중에서 인라인 클로저라고 이야기 한다
studyWithMe(study: { () -> Void in
    print("iOS 개발자를 위해 열공중")
})
// 바디가 길어지면 함수인지 뭔지 알아보기 힘들 것이다 (정통적인 방법으로는)
// -> (문제) 언제 시작해서 언제 끝나는지 너무 동떨어져 있어서 알아보기 힘듦
// trailing closure: 함수임을 명확하게 확인하기 위해서 ()을 먼저 붙임, study 생략
studyWithMe() { () -> Void in
    print("iOS 개발자를 위해 열공중")
}
// return키워드가 없으니까 반환값 없는 것을 아니까 생략, 바디에도 매개변수가 없는 것도 알겠다 \(매개변수)같은거 없으니까 생략, 구분자 in 필요없겠다
studyWithMe() {
    print("iOS 개발자를 위해 열공중")
}
// 함수호출연산자도 생략해서 사용해도 되겠다
studyWithMe {
    print("iOS 개발자를 위해 열공중")
}

// 매개변수가 있을 때는 in 생략 불가능
// (Int) -> String
func randomNumber(number: Int) -> String {
    let random = Int.random(in: 1...number)
    return "오늘의 행운의 숫자는 \(random)입니다."
}
randomNumber(number: 100)

func todayNumber(result: (Int) -> String) {
    result(300)
    // result 실행 -> randomNumber실행, number에 300
    // "오늘의 행운의 숫자는 106입니다."
}
todayNumber(result: randomNumber)
todayNumber(result: randomNumber(number:))
//todayNumber(result: {
//    let random = Int.random(in: 1...number)  // number가 어디서 온거지? -> 매개변수명에서 온건지 알려줘야 함
//    return "오늘의 행운의 숫자는 \(random)입니다."
//})

// 인라인 클로저 형태
todayNumber(result: { (jack: Int) -> String in
    let random = Int.random(in: 1...jack)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

// 어짜피 리턴에 String타입이 들어있어서 String return하는지 알고 있다 -> 반환값 생략 가능
todayNumber(result: { (jack: Int) in
    let random = Int.random(in: 1...jack)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

// 매개변수에 Int타입이 들어가는 걸 알고 있으니까 생략 가능 (반환값과 구분하는 ()도 필요 없겠다)
todayNumber(result: { (jack) in
    let random = Int.random(in: 1...jack)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

todayNumber(result: { jack in
    let random = Int.random(in: 1...jack)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

// 매개변수가 하나이면 내가 그냥 지칭해줄까? jack이라는 걸 굳이 의미 없을 것 같은데 안 쓸 수 없나?
    // 매개변수에 네이밍을 지정해주지 않으면서 어떻게 매개변수를 쓰지? -> $0을 사용해서 내부적으로 만들어주는 상수 등을 사용할 수 있다
    // 그러면 in도 필요 없어서 생략 가능
    // $0은 매개변수명을 생략할 때 사용
todayNumber(result: {
    let random = Int.random(in: 1...$0)
    return "오늘의 행운의 숫자는 \(random)입니다."
})
// 따라서 스냅킷 코드를 사용할 때도 in을 생략하고 $0을 사용할 수 있다
    // 하지만 바꾸는게 더 손이 많이 가니까 사용 X
/*
titleLabel.snp.makeConstraints {
    $0.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
}
 */

// trailing closure
/*
    // 언제 함수가 끝날 지 모르기 때문에 닫힌 소괄호를 앞쪽으로 땡긴다: 이거는 함수였어, 함수임을 알려주기 위해서
todayNumber() result: {  // 그러면 result:가 오갈 데가 없으니까 생략 -> 함수 호출되는거 어쩌피 알지? ()생략
    let random = Int.random(in: 1...$0)
    return "오늘의 행운의 숫자는 \(random)입니다."
}
 */
// 따라서 왜 함수 호출 연산자가 없어졌는지, 매개변수명 in이 왜 생략됐는지 어떻게 이 형태가 됐는지 이해
todayNumber {
    let random = Int.random(in: 1...$0)
    return "오늘의 행운의 숫자는 \(random)입니다."
}

// completionHandler입장에서, 클로저를 익명함수로서, 이름 없는 함수로 많이 사용하기 때문에 형태 변화에 대한 설명
