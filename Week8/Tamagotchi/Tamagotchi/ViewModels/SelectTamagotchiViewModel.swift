//
//  SelectTamagotchiViewModel.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectTamagotchiViewModel {
    struct Input {
        
    }
    
    struct Output {
        let skinList: BehaviorRelay<[Select]>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let list = [
            Select(name: Skin.tingly.rawValue, image: "1-6"),
            Select(name: Skin.smiley.rawValue, image: "2-6"),
            Select(name: Skin.flash.rawValue, image: "3-6"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage"),
            Select(name: Skin.empty.rawValue, image: "noImage")
        ]
        
        let skinList = BehaviorRelay(value: list)
        
        return Output(skinList: skinList)
    }
}
