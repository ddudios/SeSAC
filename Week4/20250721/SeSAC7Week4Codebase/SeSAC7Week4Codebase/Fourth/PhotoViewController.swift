//
//  PhotoViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

// 포토뷰컨트롤러에 뷰디드로드에 모든 함수 프린트
// 상속받는 구조라서 셀프로 구분이 좀어려워서 코드 수정
class PhotoViewController: BaseViewController {
    // 베이스뷰컨이 뷰컨상속받아서 뷰로 사용 가능

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Photo", #function)
    }
    
    override func setupHierarchy() {
        print("Photo", #function)
    }
    
    override func setupLayout() {
        print("Photo", #function)
    }
    
    override func setupView() {
//        super.setupView()
        print("Photo", #function)  // 세개중 하나만 슈퍼클래스 호출
    }
}

//재정의되고있어서 포토뷰에 해당하는 것만 실행
