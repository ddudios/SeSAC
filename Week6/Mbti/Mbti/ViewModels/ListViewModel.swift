//
//  ListViewModel.swift
//  Mbti
//
//  Created by Suji Jang on 9/2/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ListViewModel: RxViewModelProtocol {
    struct Input {
        let rightBarbuttonTap: ControlEvent<()>
        let searchText: ControlProperty<String>
        let searchTap: ControlEvent<Void>
        let tableViewCellModel: ControlEvent<Person>
    }
    
    struct Output {
        let sendData: PublishRelay<String>
        let list: BehaviorRelay<[Person]>
        let recentTapList: BehaviorSubject<[String]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let sendData = PublishRelay<String>()
        let sampleKoreanUsers: [Person] = [
            // 김씨 그룹
            Person(name: "김민준", email: "minjun.kim@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/31.jpg"),
            Person(name: "김서연", email: "seoyeon.kim@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/31.jpg"),
            Person(name: "김도윤", email: "doyoon.kim@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/32.jpg"),
            Person(name: "김하은", email: "haeun.kim@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/32.jpg"),
            
            // 이씨 그룹
            Person(name: "이현우", email: "hyunwoo.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/33.jpg"),
            Person(name: "이수민", email: "sumin.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/33.jpg"),
            Person(name: "이준호", email: "junho.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/34.jpg"),
            Person(name: "이유진", email: "yujin.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/34.jpg"),
            
            // 박씨 그룹
            Person(name: "박지후", email: "jihoo.park@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/35.jpg"),
            Person(name: "박지민", email: "jimin.park@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/35.jpg"),
            Person(name: "박서준", email: "seojun.park@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/36.jpg"),
            Person(name: "박예린", email: "yerin.park@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/36.jpg"),
            
            // 최씨 그룹
            Person(name: "최민호", email: "minho.choi@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/37.jpg"),
            Person(name: "최다은", email: "daeun.choi@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/37.jpg"),
            Person(name: "최유찬", email: "yuchan.choi@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/38.jpg"),
            Person(name: "최서현", email: "seohyun.choi@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/38.jpg"),
            
            // 정씨 그룹
            Person(name: "정태현", email: "taehyun.jung@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/39.jpg"),
            Person(name: "정예은", email: "yeeun.jung@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/39.jpg"),
            Person(name: "정우진", email: "woojin.jung@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/40.jpg"),
            Person(name: "정서영", email: "seoyoung.jung@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
            
            // 한씨 그룹
            Person(name: "한도현", email: "dohyun.han@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/41.jpg"),
            Person(name: "한지우", email: "jiwoo.han@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/41.jpg"),
            
            // 조씨 그룹
            Person(name: "조민석", email: "minseok.cho@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/42.jpg"),
            Person(name: "조유나", email: "yuna.cho@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/42.jpg")
        ]
        let list = BehaviorRelay(value: sampleKoreanUsers)
        let recentTapList = BehaviorSubject<[String]>(value: [])
        
        input.rightBarbuttonTap
            .bind(with: self) { owner, _ in
                sendData.accept("ListVM > ListVC > DetailVM > DetailVC")
            }
            .disposed(by: disposeBag)
        
        input.searchText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                let filterList = text.isEmpty ? sampleKoreanUsers : sampleKoreanUsers.filter { $0.name.contains(text) }
                list.accept(filterList)
            }
            .disposed(by: disposeBag)
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .bind(with: self) { owner, text in
                let filterList = text.isEmpty ? sampleKoreanUsers : sampleKoreanUsers.filter { $0.name.contains(text) }
                list.accept(filterList)
            }
            .disposed(by: disposeBag)
        
        input.tableViewCellModel
            .bind(with: self) { owner, person in
                var recentTapListValue = try! recentTapList.value()
                if !recentTapListValue.contains(person.name) {
                    recentTapListValue.append(person.name)
                    recentTapList.onNext(recentTapListValue)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(sendData: sendData, list: list, recentTapList: recentTapList)
    }
}
