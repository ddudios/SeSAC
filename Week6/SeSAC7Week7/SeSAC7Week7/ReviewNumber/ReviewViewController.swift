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
         # 왜 text bind 안찍히지?
         ## ViewModel의 bind도 항상 실행되는 것이 아니라, 즉시 실행할지 말지에 대한 여부가 달라짐
         Observable Init
         ReviewViewModel
         Observabe lazyBind
         viewDidLoad()
         */
        /**
         lazyBind면 내부가 실행되지 않는 환경, 그런데 viewDidLoad시점보다 항상 먼저 ViewModel의 bind가 먼저 동작한다(Observable lazyBind)
         - ViewController의 viewDidLoad보다 ViewModel이 항상 먼저 인스턴스가 만들어짐
         - 그걸 다시 풀면 ViewController의 viewDidLoad가 동작되는 시점에는 이미 text.lazyBind가 이미 Observable의 action에 들어가 있어서 nil이 아닌 상태로, 이미 등록이 된 상태
         - 그렇기 때문에 viewController에서 lazyBind를 했다고 하더라도 viewDidLoad시점에 viewModel을 통해서 text의 value를 통해서 어떤 문자열을 전달하는 순간은 ViewModel로 데이터를 전달하거나 input으로 보내는 순간은, 항상 didSet이 동작할 수밖에 없는 환경
         - 따라서 lazyBind라고 하더라도 viewModel.text.value = ""값을 주기 전에 action에는 등록이 되어있고, action이 등록이 되어 있으니까 value의 값을 바꾸면 bind가 동작을 할 수밖에 없는 상황으로 자연스럽게 만들어짐
         - 그래서 인스턴스 마다 init마다 print를 찍어보면 코드의 순서의 흐름을 잘 볼 수 있다
         */
        
    }
}


final class ReviewViewController: UIViewController {
    
//    let number = ReviewObservable(100)
    
    let viewModel = ReviewViewModel()
    /**
     # ViewController를 띄우기 위해서는 ViewModel이 필요하고, 이 ViewModel의 인스턴스를 생성하기 위해서는 ViewModel이 갖고있는 클래스의 프로퍼티들도 다 초기화되어야 한다
     ## 그래서 처음에 Observable Init 실행 -> ViewModel의 Init을 통해서 ReviewViewModel이 출력되고 -> text에 bind가 있다보니까 Observable Bind 실행 -> text bind를 거쳐서 -> viewDidLoad실행 (바로 실행되는 액션을 가지고 있음)
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
