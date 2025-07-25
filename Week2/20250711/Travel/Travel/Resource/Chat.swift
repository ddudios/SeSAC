//
//  Chat.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import UIKit
//채팅 화면에서 사용할 데이터 구조체
struct Chat: Hashable {
    let user: User
    let date: String
    let message: String
}
