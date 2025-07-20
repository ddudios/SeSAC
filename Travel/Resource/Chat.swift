//
//  Chat.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import UIKit
//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    let message: String
}

struct CustomDate {
    static private func dateFormat(_ chatDate: String) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        guard let dateFormatting = dateFormat.date(from: chatDate) else {
            print("error: \(#function)")
            return Date()
        }
        return dateFormatting
    }
    
    static func formattingDay(_ chatDate: String) -> String {
        let dateStringFormat = DateFormatter()
        dateStringFormat.dateFormat = "yy.MM.dd"
        return dateStringFormat.string(from: dateFormat(chatDate))
    }
    
    static func formattingHour(_ chatDate: String) -> String {
        let dateStringFormat = DateFormatter()
        dateStringFormat.dateFormat = "hh:mm a"
        dateStringFormat.locale = Locale(identifier: "ko_KR")
        return dateStringFormat.string(from: dateFormat(chatDate))
    }
}
