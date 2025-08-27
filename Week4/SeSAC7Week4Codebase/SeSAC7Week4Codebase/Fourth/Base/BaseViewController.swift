//
//  BaseViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/28/25.
//

import UIKit

class BaseViewController: UIViewController {
    // 뷰컨상속받은 베이스 뷰컨
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 베이스뷰컨 생기기 직전에 함수호출
        print("Base", #function)
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    func setupHierarchy() {
        print("Base", #function)
    }
    
    func setupLayout() {
        print("Base", #function)
    }
    
    func setupView() {
        view.backgroundColor = .white  // 베이스상속받으면 모두 배경 화이트
        print("Base", #function)
    }
}

// 재정의시 오버라이드특성때문에 부모꺼는 호출안됨, 수퍼호출한건 부모도 가져오고 자기꺼도 가져오고
// 베이스를 가져올지말지 선택
// 확장성 <-> 성능
// 상속받으면 private사용불가능
// 베이스왜써? 고작 세개 호출 중복 안하려고
// 모든 뷰컨에서 얼럿쓴다고 치면 베이스뷰컨으로 어느정도 묶어놓을 수 있음 - 얼럿띄우는 코드를 BaseVC
// 키보드 내리기도 만들어놓으면 베이스뷰컨의 모든 메서드 활용 가능한 구조 - 익스텐션보다 이게 더 좋을 수도 있겠다(매번 고려하지 않아도 된다는 관점에서)
