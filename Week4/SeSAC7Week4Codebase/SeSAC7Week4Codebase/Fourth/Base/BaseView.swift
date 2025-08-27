//
//  BaseView.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/28/25.
//

import UIKit

class BaseView: UIView {
    // UIView는 모든 뷰의 최종 단계
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(self, #function)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // required를 안쓸 걸앎
    // 버전대응에 쓰는 코드
    @available(*, unavailable)  // 앞으로 안쓸거다에 대한 명세
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @available(*, 15.0)??
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
    }
}

// 유아이뷰를 상속받은 베이스뷰, 베이스뷰를 사용받은 무언가뷰
