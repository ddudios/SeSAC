//
//  ReviewViewController.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/12/25.
//

import UIKit

final class ReviewViewModel {
    let text = ReviewObservable("안녕하세요")
    
    // 일단 찍어보고 이상하면 lazyBind/bind
    
    // viewController보다 viewModel이 먼저 init될 수밖에 없다.
    // 즉, Observable의 didSet action에 기능이 들어간 상태
    init() {
        print("ReviewViewModel")
        
//        text.bind {
//            print("text bind")
//        }
        /**
         Observable Init
         ReviewViewModel
         Observabe Bind
         text bind
         viewDidLoad()
         */
        
        text.lazyBind {
            print("text lazyBind")
        }
        /**
         Observable Init
         ReviewViewModel
         Observabe lazyBind
         viewDidLoad()
         */
    }
}


final class ReviewViewController: UIViewController {
    
//    let number = ReviewObservable(100)
    
    let viewModel = ReviewViewModel()
    //MARK: - 2:18
    /**
     #뷰컨띄우기 위해서는 뷰모델이 만들어져야하고 뷰모델
     Observable Init
     ReviewViewModel
     Observabe Bind
     text bind
     viewDidLoad()
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(#function)
        
        //MARK: - 2:22
        
//        printBind()
//        printLazyBind()
    }
    
    /*
    func printBind() {
        number.bind {
            print("number bind")
            self.navigationItem.title = "\(self.number.value)"
            /**
             모든 값이 다 초기화 되어야하기 때문에 viewDidLoad보다 먼저 Observable Init이 호출됨
             Observable Init
             viewDidLoad()
             Observabe Bind
             number bind  #데이터 변경되지 않아도 action일단실행 + 기능 할당
             */
        }
        
        number.value = 50
        /**
         Observable Init
         viewDidLoad()
         Observabe Bind
         number bind  #bind의 즉시실행action()
         Observable didSet
         number bind  #didSet의 action?()
         */
    }
    
    func printLazyBind() {
        number.lazyBind {
            print("number bind")
            self.navigationItem.title = "\(self.number.value)"
        }
        /**
         Observable Init
         viewDidLoad()
         Observabe lazyBind  #즉시실행이 안되니까 들어만 있고 값이 변하기 전에는 실행되지 않음
         */
        
        number.value = 50
        /**
         Observable Init
         viewDidLoad()
         Observabe lazyBind
         Observable didSet
         number bind
         */
    }
     */
}
