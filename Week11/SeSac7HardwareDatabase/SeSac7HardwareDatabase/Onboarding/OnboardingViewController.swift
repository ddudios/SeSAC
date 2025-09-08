//
//  OnboardingViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/8/25.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// 열거형
// 멤버와 값을 분리, rawValue
// case를 뭉쳐서 배열의 형태로 사용, CaseIterable
/*@frozen*/ private /*다른 파일에서 접근못하도록*/enum Onboarding: Int {  // 우리가 쓰는 프로젝트 내에서는 의미가 없음, 오픈소스화했을 때는 의미가 있음
    case first = 0
    case second
    case third
}
// 애플도 내 프로젝트 외부에 있는 것이기 때문에 컴파일 최적화가 됨
// 겨울왕국 인투디 언논

// enum 클래스 내부에서만 사용한다면 class 내부에 넣어두기

// UIPageViewController: 여러 뷰컨을 묶어주는 역할
final class OnboardingViewController: UIPageViewController {
    
    // 1. UIViewController를 여러 개 담을 그릇
    var list: [UIViewController] = []
    
    // default값인 책 넘기는 모션은 사용자 입장에서 여러번 보면 피곤할 수 있다
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        // style이 scroll일 때만 Page Control 보임
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        view.backgroundColor = .systemPink
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }  // 0번에 해당하는 요소가 있다면 아래 코드 실행
        
        // 처음에 어떤 화면을 보여줄 지
//        setViewControllers([list[0]], direction: .forward, animated: true)
        // 0번 index가 존재하지 않는다면 런타임 오류
        // first는 없을 수도 있다는 것을 가정하고 가져오는 거라서 Nil에 대한 처리가 가능 (최소 런타임 오류는 발생하지 않음)
        // 따라서 list[0]보다는 list.first 사용
        setViewControllers([first], direction: .forward, animated: true)
        
        getRandom()
        
        // @unknown: 멤버가 추가될 가능성이 있는 열거형, unfrozen Enum (라이브러리, 프레임워크에서 주로 등장하는 부분)
        let a = NSTextAlignment.center  // text 다 중앙으로 보내겠다
        switch a {
        case .left:
            <#code#>
        case .center:
            <#code#>
        case .right:
            <#code#>
        case .justified:
            <#code#>
        case .natural:
            <#code#>
        @unknown default:
            <#fatalError()#>
        }
        
        // Optional이 다 열거형 기반
            // none(non-Optinal), some(Optional) 2가지 케이스: @frozen
        // frozen Enum: 절대로 앞으로 멤버가 달라질 리가 없을 때 @frozen (성능 최적화)
//        let a = Optional(<#T##some: ~Copyable##~Copyable#>)
        
    }
    
    // 어디서는 반환값을 사용하고, 어디서는 반환값을 사용하지 않을 수 있다 -> 반환값을 사용하지 않아도 warning이 뜨지 않음
    @discardableResult
    func getRandom() -> Int {
        let random = Int.random(in: 1...100)
        print(random)
        return random
    }
    
    // @: Swift Attribute: 편하라고 지원하는 것
    // - 선언에 대한 어트리뷰트
    // - 타입에 대한 어트리뷰트
    // - 스위치 케이스에 대한 어트리뷰트
    // - available, frozen, objc, main 등
}

// ViewController에 대한 Delegate
extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // Page Control
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0  // 첫 화면 뭐뜰지
        
        guard let first = viewControllers?.first,  // pageViewController가 가지고 있는 기본 속성 중 가장 첫번째 뷰컨을 꺼내서 담고
              let index = list.firstIndex(of: first) else {  // 그게 있다면 index에 담아서
            return 0
        }
        return index
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 ViewController를 기준으로 이전 화면은 뭘 준비하면 될지 알려줌
        
        // 현재 보고 있는 뷰컨 배열의 인덱스
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }  // 현재 0번을 보고 있다면 그 앞은 없으니까 nil
        
        // 내가 2번 뷰컨이라면 이전 뷰컨은 1번이다
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 내가 현재 3페이지일 때 그 다음은 4페이지를 준비해달라
        // 현재 4페이지라면 다음 페이지가 없어서 nil로 설정
        
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        // 내가 2번 뷰컨이라면 다음에는 3번 뷰컨을 띄우겠다
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
}
