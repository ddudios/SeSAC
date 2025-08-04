//
//  UIButton+Extension.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/4/25.
//

import UIKit

// UIButton에 대한 extension이 아니라, UIButton안에 Configuration안에서만 확장
    // 내가 작성하는 코드들은 결국엔 Configuration안에 들어있음
    // 예전 버전들에서는 UIButton의 Configuration의 외적인 부분들에 대해서는 담당하고 싶지 않다, 정말 필요한 부분에서만 담당하도록 설정

// jackStyle메서드는 Configuration에 있기 때문에 어떻게 보면 UIButton에서도 모른다
    // UIButton박스 안에 Configuration박스까지 들어와야 알 수 있는 존재
extension UIButton.Configuration {
    // UIButton 안에 Configuration 구조체 안에 filled() 대신에 뭔가를 쓰고 싶은 거여서 filled()의 구조를 그대로 따온 것
        // static func filled() -> UIButton.Configuration
    // UIButton.Configuration.filled()의 형태
    // 매개변수없이 일정한 버튼이라면 연산프로퍼티 사용 고려
    static func jackStyle(title: String) -> UIButton.Configuration {
        
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "star")
        config.cornerStyle = .capsule
        
        return config
    }
}
