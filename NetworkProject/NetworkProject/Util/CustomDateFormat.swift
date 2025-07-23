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
