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
//        let selectedItem: Observable<Setting>
    }
    
    func transform(input: Input) -> Output {
        // 데이터 가공하는 Observer
        let settings = [
            Setting(icon: "pencil", title: "내 이름 설정하기", subTitle: UserDefaultsManager.shared.nickname),
            Setting(icon: "moon.fill", title: "다마고치 변경하기", subTitle: nil),
            Setting(icon: "arrow.clockwise", title: "데이터 초기화", subTitle: nil)
        ]
        
        let items = BehaviorRelay(value: settings)
        
//        let selectedItem = input.modelSelected
//            .drive(with: self) { owner, item in
//                switch item.title {
//                case "내 이름 설정하기":
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let viewController = storyboard.instantiateViewController(identifier: "NicknameSettingViewController") as! NicknameSettingViewController
//                    owner.navigationController?.pushViewController(viewController, animated: true)
//                case "다마고치 변경하기":
//                    let viewController = SelectTamagotchiViewController()
//                    owner.navigationController?.pushViewController(viewController, animated: true)
//                case "데이터 초기화":
//                    super.showAlert(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", cancelText: "아냐!", okText: "웅") {
//                        print("데이터 초기화")
//                    }
//                default:
//                    break
//                }
//            }
//            .disposed(by: disposeBag)
        
        return Output(items: items/*, selectedItem: selectedItem*/)
    }
}
