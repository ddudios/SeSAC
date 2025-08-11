//
//  WrappedData.swift
//  MVVMBasic
//
//  Created by Suji Jang on 8/11/25.
//

import Foundation

final class Observable<T> {
    private var ready: ((T) -> Void)?  // 처음에 nil
    
    var data: T {
        didSet {
            ready?(data)  // 변경된 데이터로 기능 실행
        }
    }
    
    init(_ value: T) {  // 인스턴스 생성 시점에 관찰할 데이터를 원하는 타입으로 초기화
        self.data = value
    }
    
    // data <-연결-> UI
    func binding(makeAction: @escaping (T) -> Void) {
        // 관찰하는 데이터를 활용하는 가공/외부 메서드 당장 실행 + 할당
        makeAction(data)
        ready = makeAction
    }
}
