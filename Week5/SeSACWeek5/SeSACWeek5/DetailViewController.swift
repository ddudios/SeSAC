//
//  DetailViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 7/31/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let field = UITextField()
    
    // 함수를 A화면에서 B화면으로 전달
//    var content: String?
//    var content: (() -> Void)?  // 화면전환이 되면서 안녕하세요 함수기능 들어오면
    var content: ((String) -> Void)?
    
    /*
    // 함수 -> 익명함수
    func hello(name: String) {
        print(name)
    }
    { name in
        print(name)
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "디테일 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        view.addSubview(field)
        field.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        field.placeholder = "입력해보세요"
//        field.text = content
        
        // responder chain
            // 사용자는 유리 클릭 -> UIWindow -> ViewController위에 이거 저거 거쳐서 -> TextField
            // 이들은 체인방식으로 연결돼서 전부 거쳐가면서 내꺼 아니야 ~ ~ ~ ~ ~ ~ ~ ~ ~하다가 내꺼야
        field.becomeFirstResponder()  // 타이밍 조절에 따라 더 자연스럽게 연출 가능
        // 화면에 들어오면 TextField가 클릭된 것처럼 보여줄 수 있다
        // 가장 처음 클릭된 형태로 만들어줄 수 있다
    }
    
    @objc func closeButtonClicked() {
        print(#function)
        
//        content?()  // 기능 실행
        // content프로퍼티 자체가 옵셔널이라서 ?붙음
        // 이 함수가 nil이 아니라면 실행
        
        content?(field.text!)
        
        // present - dismiss / push - pop
        self.dismiss(animated: true)
        
        // 시점에 따라 view.endEditing(true)과 같은 효과를 낼 수 있다
            // 지금은 텍스트필드가 하나만 있기 때문에 그냥 사용하면 되는데 다른 텍스트필드가 있으면 키보드가 안내려갈 수도 있음
        // 반응을 다 멀어지게 해달라: 반응할 필요없다고 거절
//        field.resignFirstResponder()
    }
}
