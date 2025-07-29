//
//  NaverShoppingService.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import Alamofire

struct NaverSearch: Decodable {
    var total: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
}

struct NaverShoppingUrl {
    var query: String
    var sort: String
    var url: String
    
    init(query: String, sort: String, start: Int) {
        self.query = query
        self.sort = sort
        self.url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30\(sort)&=\(String(start))"
    }
}
