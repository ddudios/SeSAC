//
//  Lotto.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/24/25.
//

import Foundation

// 이 구조체는 외부에서 오는 String을 담는 역할이구나 라고 Decodable채택을 통해 알게할 수 있음
struct Lotto: Decodable {  // 쓰고 싶은 정보만 발라낸다 (복사해서 넣기: 외부 데이터 key 오타나면 안됨)
    let drwNoDate: String
    let bnusNo: Int  // 큰따옴표가 없기 때문에 Int로 오고 있는 것 (타입이 어떻게 오는지는 웹사이트에 명시되어있음)
}
