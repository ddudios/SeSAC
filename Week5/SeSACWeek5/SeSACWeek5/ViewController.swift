//
//  ViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/29/25.
//

import UIKit

class ViewController: UIViewController {
    
//    let a = APIKey()
    // .찍어서 가져올 거니까 불필요한 공간을 만들 필요가 없다
    // 코드의 의도전달시 다른 사람은 이렇게 사용할 수도 있다

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
//        a.  // 내부에 인스턴스가 없어서 어쩌피 꺼내올 것도 없다
        print(APIKey.kakaoKey)  // git에 이 내용은 보이지만, 안에 무슨 내용이 있는지 깃에서는 못봄
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showAlert(title: "상품을 좋아요에 등록할까요?", message: "이 상품이 만족스러우신가요?", ok: "저장", vc: self)
//        showAlert(title: "상품 삭제", message: "상품을 삭제할까요?", ok: "삭제")
        showAlert(title: "테스트", message: "얼럿이 떴습니다", ok: "배경바꾸기") {
            print("버튼을 클릭했어요")
            self.view.backgroundColor = .yellow
        }
    }
}
