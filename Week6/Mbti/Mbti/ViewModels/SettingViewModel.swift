//
//  SettingViewModel.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: RxViewModelProtocol {
    struct Input {
        let nickname: ControlProperty<String>
        
        let eButtonTap: ControlEvent<Void>
        let iButtonTap: ControlEvent<Void>
        
        let sButtonTap: ControlEvent<Void>
        let nButtonTap: ControlEvent<Void>
        
        let tButtonTap: ControlEvent<Void>
        let fButtonTap: ControlEvent<Void>
        
        let jButtonTap: ControlEvent<Void>
        let pButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameValidateText: BehaviorRelay<String>
        let nicknameValidateColor: PublishRelay<Bool>
        
        let eButtonStatus: BehaviorRelay<Bool>
        let iButtonStatus: BehaviorRelay<Bool>
        
        let sButtonStatus: BehaviorRelay<Bool>
        let nButtonStatus: BehaviorRelay<Bool>
        
        let tButtonStatus: BehaviorRelay<Bool>
        let fButtonStatus: BehaviorRelay<Bool>
        
        let jButtonStatus: BehaviorRelay<Bool>
        let pButtonStatus: BehaviorRelay<Bool>
        
        let completeButtonStatus: BehaviorRelay<Bool>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let nicknameValidateText = BehaviorRelay(value: "")
        let nicknameValidateColor = PublishRelay<Bool>()
        
        let eButtonStatus = BehaviorRelay(value: false)
        let iButtonStatus = BehaviorRelay(value: false)
        
        let sButtonStatus = BehaviorRelay(value: false)
        let nButtonStatus = BehaviorRelay(value: false)
        
        let tButtonStatus = BehaviorRelay(value: false)
        let fButtonStatus = BehaviorRelay(value: false)
        
        let jButtonStatus = BehaviorRelay(value: false)
        let pButtonStatus = BehaviorRelay(value: false)
        
        let completeButtonStatus = BehaviorRelay(value: false)
        
        input.nickname
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if text.isEmpty {
                    nicknameValidateText.accept("")
                    completeButtonStatus.accept(false)
                } else if text.count < 2 || text.count > 9 {
                    nicknameValidateText.accept("2글자 이상 10글자 미만으로 설정해주세요")
                    nicknameValidateColor.accept(false)
                    completeButtonStatus.accept(false)
                } else if text.contains(where: ["@", "#", "$", "%"].contains) {
                    nicknameValidateText.accept("@, #, $, % 4개의 특수문자 및 숫자 사용 불가")
                    nicknameValidateColor.accept(false)
                    completeButtonStatus.accept(false)
                } else {
                    nicknameValidateText.accept("사용할 수 있는 닉네임이에요")
                    nicknameValidateColor.accept(true)
                    completeButtonStatus.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        buttonTapped(tap: input.eButtonTap, status: eButtonStatus)
        buttonTapped(tap: input.iButtonTap, status: iButtonStatus)
        
        buttonTapped(tap: input.sButtonTap, status: sButtonStatus)
        buttonTapped(tap: input.nButtonTap, status: nButtonStatus)
        
        buttonTapped(tap: input.tButtonTap, status: tButtonStatus)
        buttonTapped(tap: input.fButtonTap, status: fButtonStatus)
        
        buttonTapped(tap: input.jButtonTap, status: jButtonStatus)
        buttonTapped(tap: input.pButtonTap, status: pButtonStatus)
        
        Observable.combineLatest(eButtonStatus, iButtonStatus)
            .bind(with: self) { owner, buttonStatus in
                print("")
            }
            .disposed(by: disposeBag)
        
        return Output(nicknameValidateText: nicknameValidateText, nicknameValidateColor: nicknameValidateColor, eButtonStatus: eButtonStatus, iButtonStatus: iButtonStatus, sButtonStatus: sButtonStatus, nButtonStatus: nButtonStatus, tButtonStatus: tButtonStatus, fButtonStatus: fButtonStatus, jButtonStatus: jButtonStatus, pButtonStatus: pButtonStatus, completeButtonStatus: completeButtonStatus)
    }
    
    private func buttonTapped(tap: ControlEvent<Void>, status: BehaviorRelay<Bool>) {
        tap
            .bind(with: self) { owner, _ in
                if status.value {
                    status.accept(false)
                } else {
                    status.accept(true)
                }
            }
            .disposed(by: disposeBag)
    }
}
