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
            print("UpbitDetailViewModel Init")
    }
    
    deinit {
        print("UpbitDetailViewModel Deinit")
        // 클래스에서는 항상 찍어서 확인 -> 찍히면 오케이
        // -> 안찍히면 잡아내기
        // 요즘은 메모리 누수 생겨도 별 티는 안나지만, 발열의 문제는 이런 메모리 누수 문제일 수도 있음
        // deinit이 찍히지 않으니까 Detail은 사라졌기 때문에 다시 접근해서 지워줄 수 없음, 누수 발생중 -> 해결해줘야함
        // 1. 일단 클로저, self키워드 찾아서 해결
    }
}
