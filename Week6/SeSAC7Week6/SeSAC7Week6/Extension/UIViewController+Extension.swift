//
//  UIViewController+Extension.swift
//  SeSAC7Week6
//
//  Created by Suji Jang on 8/7/25.
//

import UIKit

extension UIViewController {
    // 같은 기능의 메서드 여러개 생성
//    func total(a: Int, b: Int) -> Int {
//        return a + b
//    }
//    
//    func total(a: Double, b: Double) -> Double {
//        return a + b
//    }
//    
//    func total(a: Float, b: Float) -> Float {
//        return a + b
//    }
    
    /*
    // 어떻게 a, b에 모든 타입을 넣어도 괜찮을 수 있을까? <Generaic>
        // 타입이 누가 들어와도 괜찮은 상황으로 만들고 싶다 (네모박스로 만들기)
        // 네모박스 표기법 <>: 매개변수가 활용되기 전에 이게 네모박스라는 것을 알려준다
        // 박스로 명세한 것을 바로 사용할 수 있다
    // 받아온 매개변수를 그대로 보여줌
    func total<Jack>(a: Jack, b: Jack) -> Jack {
        print(b)
        return a
        // 단순히 출력은 괜찮은데, 연산하려고 하면 오류
            // Jack에는 타입만 일치하면 다 들어갈 수 있기 때문에 true/false, tableView+tableView도 들어갈 수 있음
            // 단순히 테이블뷰를 보내는것까지는 괜찮은데 테이블뷰+테이블뷰를 어떻게?
            // 한정되게 들어올 수 있게 설정 : 어떤 특성을 갖고 있는 타입만 들어오면 좋겠어
    }*/
    
    // 프로토콜 제약
    func total<Jack: Numeric>(a: Jack, b: Jack) -> Jack {
        print(b)
        return a
        // 덧셈이 될 수 있는 타입: AdditiveArithmetic
        // 연산이 될 수 있는 타입: Numeric 프로토콜을 채택한 것들만 가능(문서살펴보기)
    }
    
    /*
    func setCornerRadius(a: UIImageView) {
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }
    
    func setCornerRadius(a: UIButton) {
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }
    
    func setCornerRadius(a: UIView) {  // 로도 가능하지만 Generic 활용
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }*/
    // 타입 파라미터에 타입 제약 설정해줘야 한다
        // UIView타입을 지녔다면 다 들어와도 괜찮겠다
    // 클래스 제약
    func setCornerRadius<SeSAC: UIView>(a: SeSAC) {
        a.layer.cornerRadius = 10
        a.clipsToBounds = true
    }
    // T를 사용하지 않으면 T에 뭐가 들어가야할 지 모르겠다는 오류
    
    // 제네릭을 활용한 경우, 선언된 함수에서는 어떤 타입이 들어올 지 알 수 없고,
    // 직접 실행하거나 활용할 때 타입이 나중에 들어오게 됨
    // 즉 타입을 유추할 수 없음
    
    // 이 함수만 보고 a가 버튼이구나, 뷰구나, 타입을 알 수 없음
    // 제약설정을 해주긴 했지만, 함수만 보고 Jack이 Int겠군 알 수 없음
    // 실행 전까지 어떤 타입인지 절대 알 수 없다
    // 그래서 a에 T가 아닌 다른 타입을 주면 T는 불안해
        // 어떤 타입이 들어오는지 제네릭에 알려줘야지. 내가 뭘 쓸 수 있는데? 아니면 내가 T에 뭐가 들어오는지 어떻게 알겠어
    // 굳이 제네릭으로 바꿔가면서 연습
}

// 제네릭
// 제약: 프로토콜 제약/클래스 제약
// 배열이 제네릭 구조로 만들어져 있음
