//
//  CustomStruct.swift
//  Travel
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

struct CustomFont {
    static let headline2 = UIFont.systemFont(ofSize: 28, weight: .semibold)
    static let subtitle = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let caption = UIFont.systemFont(ofSize: 15, weight: .medium)
    
    static let headline1 = UIFont.systemFont(ofSize: 35, weight: .bold)
    static let title1 = UIFont.systemFont(ofSize: 25, weight: .bold)
    
    static let title2 = UIFont.systemFont(ofSize: 19, weight: .bold)
    static let body = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static let chatBody = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let subhead = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let footnote = UIFont.systemFont(ofSize: 12, weight: .regular)
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
    
    static func formattingChangeDay(_ chatDate: String) -> String {
        let dateStringFormat = DateFormatter()
        dateStringFormat.dateFormat = "  EEEE, MMMM dd, yyyy"
        return dateStringFormat.string(from: dateFormat(chatDate))
    }
    
    static func chattingDateForm(_ date: Date) -> String {
        let dateStringFormat = DateFormatter()
        dateStringFormat.dateFormat = "yyyy-MM-dd HH:mm"
        return dateStringFormat.string(from: date)
    }
}
