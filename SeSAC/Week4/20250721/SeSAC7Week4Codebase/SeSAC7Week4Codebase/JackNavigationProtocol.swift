//
//  JackNavigationProtocol.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/22/25.
//

import Foundation

// Optional Requirements: 선택적 요구사항
// 옵션을 갖고있다고 프로토콜에게도 알려줘야 한다
@objc protocol JackNavigationProtocol {
    // 변수명 강제화
    // ⭐️프로퍼티 요구사항은 최소 요구사항
        // get만 있으면 되고, set은 해도 되고 안해도 됨
    // 저장프로퍼티로도 쓸 수 있고 연산프로퍼티로도 쓸 수 있다 (공간을 차지하든 차지하지 않든 존재하기만 하면 신경쓰지 않는다)
    var myTitle: String { get }  // 가지고 오는 용도
    var myButton: String { get set }  // 최소 요구사항이 가져오는 것, 셋팅하는 것 모두 있어야 한다
    // 셋팅하면 가져와야지 셋팅만 하면 왜 있는거야? { set }만은 안되는 이유
    
    func configure()  // 배경, 타이틀 (무조건 쓰임) 인스턴스 메서드
    @objc optional func configureButton()  // 바버튼 (있는 뷰컨/없는 뷰컨 - 비워두기는 애매하니까 필수와 옵션으로 나눔)
    // Swift의 Optional이 아니라 옵션에 대한 명세
}

// 함수타입 정도까지만 명세할 수 있음 (자세히 매개변수에 뭐가 들어갈지 등은 쓸 수 없다)
