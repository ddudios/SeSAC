//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import Foundation

class Tamagotchi {
    var level: Int
    var rice: Int
    var water: Int
    
    init(level: Int, rice: Int, water: Int) {
        self.level = level
        self.rice = rice
        self.water = water
    }
}
