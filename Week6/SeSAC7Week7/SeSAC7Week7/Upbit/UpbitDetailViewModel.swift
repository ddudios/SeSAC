//
//  UpbitDetailViewModel.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

final class UpbitDetailViewModel {
    
    // 이전화면으로부터 전달받은 데이터이자 화면에 보이는 데이터
        // 뷰에 보여지는 역할이라면 output이라고 규정
    var outputTitle: ReviewObservable<String?> = ReviewObservable(nil)
    
    init() {
        print("UpbitDetailViewModel Init")
        print(outputTitle.value)
        
        outputTitle.bind {
            print("outputTitle Bind", self.outputTitle.value)
        }
    }
}
