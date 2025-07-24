//
//  CustomDateFormat.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/24/25.
//

import Foundation

struct CustomDateFormat {
    private static func getDateData(dateString: String) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyyMMdd"
        return dateFormat.date(from: dateString) ?? Date()
    }
    
    static func getDateString(dateData: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: getDateData(dateString: dateData))
    }
}
//MARK: 8글자 고정이라면, String->Date->String이 아니라 String 중간에 -를 넣어주는 방식으로도 구성해볼 수 있다
