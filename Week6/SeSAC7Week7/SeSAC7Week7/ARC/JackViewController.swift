//
//  JackViewController.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/14/25.
//

import UIKit

final class JackViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("JackViewController ViewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = JackDetailViewController()
        // 화면전환될때 클래스의 인스턴스를 만든거니까 init이 만들어지고 deinit과정을 거친다
            // 메모리 공간을 차지했다가 필요하지 않아졌을 때 메모리에서 내려감
        navigationController?.pushViewController(vc, animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("JackViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("JackViewController Deinit")
    }
}

/**
 JackViewController Init
 JackViewController ViewDidLoad
 JackDetailViewController Init
 JackDetailViewController ViewDidLoad
 JackDetailViewController Init
 ---
 JackDetailViewController Deinit
 JackDetailViewController ViewDidLoad
 
 - viewDidLoad시점에 VC, DVC가 공간을 차지함
 - 백버튼 누르면 DVC Deinit
 - Push/Pop때 VC는 루트뷰이기 때문에 계속 공간을 차지하고 있는데, DVC는 필요할때 공간을 차지했다가 없어졌다가를 반복함
 */
