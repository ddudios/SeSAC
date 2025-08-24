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
        let modelSelected: ControlEvent<Select>
    }
    
    struct Output {
        let skinList: BehaviorRelay<[Select]>
        let select: BehaviorRelay<Select>
    }
    
    let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let list = [
            Select(name: Skin.tingly.rawValue, image: "1-6", description: """
            저는 선인장 다마고치 입니다. 키는 2cm 몸무게는 150g이에요.
            성격은 소심하지만 마음은 따뜻해요.
            열심히 잘 먹고 잘 클 자신은 있답니다.
            반가워요 주인님!!!
            """),
            Select(name: Skin.smiley.rawValue, image: "2-6", description: """
            저는 방실방실 다마고치입니당 키는 100km
            몸무게는 150톤이에용
            성격은 화끈하고 날라다닙니당~!
            열심히 잘 먹고 잘 클 자신은
            있답니당 방실방실!
            """),
            Select(name: Skin.flash.rawValue, image: "3-6", description: """
            저는 반짝반짝 다마고치 입니다. 키는 2cm 몸무게는 150g이에요.
            성격은 소심하지만 마음은 따뜻해요.
            열심히 잘 먹고 잘 클 자신은 있답니다.
            반가워요 주인님!!!
            """),
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
        let select = BehaviorRelay(value: Select(name: "", image: ""))
        
        input.modelSelected
            .bind(with: self) { owner, value in
                select.accept(value)
            }
            .disposed(by: disposeBag)
        
        return Output(skinList: skinList, select: select)
    }
}
