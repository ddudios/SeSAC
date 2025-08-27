//
//  ProfileDetailViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/27/25.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileDetailViewController: UIViewController {
    
//    var text: String?  // 이전화면에서 값전달을 통해서 보여줬음
    // 여기서 받을 수 없을것같으니까 뷰모델로 옮겨보기
    
    let disposeBag = DisposeBag()
//    let viewModel = ProfileDetailViewModel()
    private let viewModel: ProfileDetailViewModel
    
    init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)  // 상속하는 UIViewController에 대한 init도 해줘야함, xib안씀!
    }
    // 연쇄적인 전달: VC에서는 VM, VM에서는 text
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
//        navigationItem.title = text
        
        bind()
        
//        viewModel.text = "ㅇㅇㅇ"  // 외부에서 건들일 수 있음, 불필요한 접근, 나중에 코드가 원하는 흐름으로 흘러가지 않을 수 있음
        
        
        let sample1 = Sample1()
        sample1.name = "jack"
        // 인스턴스 만들 때 이니셜라이저 구문을 통해 값을 넣어주는 형태로 변경
        let sample = Sample(name: "Jack")  // 클래스 내의 프로퍼티가 아닌 파라미터이기 때문에 private으로 name을 막아둘 수 있다
    }
    
    func bind() {
        let input = ProfileDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.navTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
