//
//  ViewDesignProtocol.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/22/25.
//

import Foundation
import UIKit
// UIKit 내부에 레이블, 버튼을 제외한 대부분의 뷰객체들은 부하직원을 거느리고 있다.
// 뷰 객체들을 도와주는 방식이 UIKit에서는 대부분 프로토콜기반으로 이루어져 있다
// 만약 면접에서 컬렉션뷰 해봤어? 안해봤다면, 다른 것들을 비교해서 다 해봤고 다 프로토콜 기준으로 이루어져 있고 프레임워크가 어떻게 생긴지 알아서 할 수 있다
// iOS의 대부분은 SwiftUI가 등장하기 전까지 거의 다 프로토콜, 델리게이트로 이루어져 있고 그래서 프로토콜을 잘 쓰고 잘 이해하는 것도 중요하고 그래서 테이블뷰랑 컬렉션뷰가 왜 이렇게 생겼는지 아는 것이 중요하다

// 뷰를 디자인하기 위해서 공통적으로 사용할 프로토콜
    // 코드를 짜다보니 계속 비슷한 이름 사용해서
// Protocol Requirements
    // Method Requirements 메서드에 대한 요구사항 명세: 틀만 만드는 개념
    // Property Requirements 프로퍼티에 대한 요구사항 명세

// 프로토콜이 서포팅 -> 구조체, 열거형, 클래스
// 구조체에 얼토당토 들어갈 수 있음, 자율적으로 채택하는 것이기 때문
    // 하나하나 신경써서 안하느니 애초에 불가능하게 만들면 좋겠다
    // 특히 UIKit은 클래스 기반으로 이루어져있으니까 구조체, 열거형에서 채택하지 못하게 AnyObject
// class에서만 사용할 protocol은 AnyObject를 채택하면 됨
    // 성능이 낮아짐 static dispatch / dynamic dispatch(mathod dispatch)

// Any Vs. AnyObject(클래스 기반)
let a: [Any] = [0, false, "hello", UILabel()]  // 모든 타입이 들어갈 수 있음
let b: [AnyObject] = []  // 클래스의 인스턴스만 들어갈 수 있음 (구조체 타입은 못들어감)

protocol ViewDesignProtocol: AnyObject {
    // 규칙
    func configureHierarchy()
    func configureLayout()
    func configureView()
}

// 요구사항을 명세
protocol UICollectionViewDataSourceJack {
    func numberOf()
    func cellForItemAt()
}

// 1. 강제
    // 회사에 가면 제일먼저 import, protocol을 본다. 이런 강제성을 가지고 만들었구나
// 2. Interface
    // 카메라 렌즈 안에가 어떻게 생긴지 궁금하지 않다
    // 볼륨을 눌렀을때 크고 작아진다는 것만 알고 있지 내부 칩셋이 어떻게 구성됐는지는 궁금하지 않는다
    // 내부가 어떻게 구성되어있는지는 궁금하지 않고 interface는 카메라 렌즈, 볼륨
    // 레이블 안이 어떻게 생긴지 궁금하지 않는다, 그 안의 코드하나하나 신경쓰지 않고 가져다 쓰기만 한다
    // 프로토콜 3개가 있는지는 아는데 어떻게 구성될지는 궁금하지 않고 가이드적인 부분으로 Interface역할을 한다
// 명세 이후에는 어디에서 호출할지만 정하면 된다
    // 어떤 뷰컨에서든 비슷한 구성으로 만들어지기 떄문에 대강의 골자를 이해할 수 있다
// 프로토콜은 명세만 할 뿐, 구현은 구현부에서 알아서
    // 내부에 어떤 것이 들어있는지는 프로토콜 입장에서 궁금하지 않다
