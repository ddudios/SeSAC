//
//  Select.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import Foundation

enum Skin: String {
    case tingly = "따끔따끔 다마고치"
    case smiley = "방실방실 다마고치"
    case flash = "번쩍번쩍 다마고치"
    case empty = "준비중이에요"
}

struct Select {
    let name: String
    let image: String
    var description: String?
}
