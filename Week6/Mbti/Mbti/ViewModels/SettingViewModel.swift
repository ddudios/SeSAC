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
        
        let completeButtonTap: ControlEvent<Void>
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
        
        let eButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "e"))
        let iButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "i"))
        
        let sButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "s"))
        let nButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "n"))
        
        let tButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "t"))
        let fButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "f"))
        
        let jButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "j"))
        let pButtonStatus = BehaviorRelay(value: UserDefaults.standard.bool(forKey: "p"))
        
        let completeButtonStatus = BehaviorRelay(value: false)
        
        input.nickname
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if text.isEmpty {
                    nicknameValidateText.accept("")
                } else if text.count < 2 || text.count > 9 {
                    nicknameValidateText.accept("2글자 이상 10글자 미만으로 설정해주세요")
                    nicknameValidateColor.accept(false)
                } else if text.contains(where: ["@", "#", "$", "%"].contains) {
                    nicknameValidateText.accept("@, #, $, % 4개의 특수문자 및 숫자 사용 불가")
                    nicknameValidateColor.accept(false)
                } else if text.contains(where: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains) {
                    nicknameValidateText.accept("닉네임에 숫자는 포함할 수 없어요")
                    nicknameValidateColor.accept(false)
                } else {
                    nicknameValidateText.accept("사용할 수 있는 닉네임이에요")
                    nicknameValidateColor.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        buttonTapped(tap: input.eButtonTap, state: eButtonStatus)
        buttonTapped(tap: input.iButtonTap, state: iButtonStatus)
        
        buttonTapped(tap: input.sButtonTap, state: sButtonStatus)
        buttonTapped(tap: input.nButtonTap, state: nButtonStatus)
        
        buttonTapped(tap: input.tButtonTap, state: tButtonStatus)
        buttonTapped(tap: input.fButtonTap, state: fButtonStatus)
        
        buttonTapped(tap: input.jButtonTap, state: jButtonStatus)
        buttonTapped(tap: input.pButtonTap, state: pButtonStatus)
        
        buttonOff(tap: input.eButtonTap, otherState: iButtonStatus)
        buttonOff(tap: input.iButtonTap, otherState: eButtonStatus)
        
        buttonOff(tap: input.sButtonTap, otherState: nButtonStatus)
        buttonOff(tap: input.nButtonTap, otherState: sButtonStatus)
        
        buttonOff(tap: input.tButtonTap, otherState: fButtonStatus)
        buttonOff(tap: input.fButtonTap, otherState: tButtonStatus)
        
        buttonOff(tap: input.jButtonTap, otherState: pButtonStatus)
        buttonOff(tap: input.pButtonTap, otherState: jButtonStatus)
        
        Observable.combineLatest(eButtonStatus, iButtonStatus, sButtonStatus, nButtonStatus, tButtonStatus, fButtonStatus, jButtonStatus, pButtonStatus)
            .bind(with: self) { owner, mbtiButtonStatus in
                if (mbtiButtonStatus.0 || mbtiButtonStatus.1) && (mbtiButtonStatus.2 || mbtiButtonStatus.3) && (mbtiButtonStatus.4 || mbtiButtonStatus.5) && (mbtiButtonStatus.6 || mbtiButtonStatus.7) {
                    Observable.combineLatest(input.nickname, nicknameValidateText)
                        .bind(with: self) { owner, nicknameState in
                            if !(nicknameState.0 == "") || (nicknameState.1 == "사용할 수 있는 닉네임이에요") {
                                completeButtonStatus.accept(true)
                            } else {
                                completeButtonStatus.accept(false)
                            }
                        }
                        .disposed(by: owner.disposeBag)
                }
            }
            .disposed(by: disposeBag)
        
        
        
        input.completeButtonTap
            .withLatestFrom(input.nickname)
            .bind(with: self) { owner, nickname in
                UserDefaults.standard.set(nickname, forKey: "nick")
                
                UserDefaults.standard.set(eButtonStatus.value, forKey: "e")
                UserDefaults.standard.set(iButtonStatus.value, forKey: "i")
                UserDefaults.standard.set(sButtonStatus.value, forKey: "s")
                UserDefaults.standard.set(nButtonStatus.value, forKey: "n")
                UserDefaults.standard.set(tButtonStatus.value, forKey: "t")
                UserDefaults.standard.set(fButtonStatus.value, forKey: "f")
                UserDefaults.standard.set(jButtonStatus.value, forKey: "j")
                UserDefaults.standard.set(pButtonStatus.value, forKey: "p")
                completeButtonStatus.accept(false)
            }
            .disposed(by: disposeBag)
        
        return Output(nicknameValidateText: nicknameValidateText, nicknameValidateColor: nicknameValidateColor, eButtonStatus: eButtonStatus, iButtonStatus: iButtonStatus, sButtonStatus: sButtonStatus, nButtonStatus: nButtonStatus, tButtonStatus: tButtonStatus, fButtonStatus: fButtonStatus, jButtonStatus: jButtonStatus, pButtonStatus: pButtonStatus, completeButtonStatus: completeButtonStatus)
    }
    
    private func buttonTapped(tap: ControlEvent<Void>, state: BehaviorRelay<Bool>) {
        tap
            .withLatestFrom(state)
            .map { !$0 }
            .bind(to: state)
            .disposed(by: disposeBag)
    }
    
    private func buttonOff(tap: ControlEvent<Void>, otherState: BehaviorRelay<Bool>) {
        tap
            .withLatestFrom(otherState)
            .filter { $0 }
            .map { _ in false}
            .bind(to: otherState)
            .disposed(by: disposeBag)
    }
}
