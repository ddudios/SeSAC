//
//  SettingViewModel.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel {
    struct Input {  // ViewController에서의 User Event Observable
        let modelSelected: ControlEvent<Setting>
    }
    
    struct Output {  // View에 표시할 데이터 Observable
        let items: BehaviorRelay<[Setting]>
    }
    
    func transform(input: Input) -> Output {
        // 데이터 가공하는 Observer
        let settings = [
            Setting(icon: "pencil", title: "내 이름 설정하기", subTitle: UserDefaultsManager.shared.nickname),
            Setting(icon: "moon.fill", title: "다마고치 변경하기", subTitle: nil),
            Setting(icon: "arrow.clockwise", title: "데이터 초기화", subTitle: nil)
        ]
        
        let items = BehaviorRelay(value: settings)
        
        return Output(items: items)
    }
}
