//
//  TamaMainViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/9/25.
//

import UIKit

class TamaMainViewController: UIViewController {
    
    // UIColor.black 계속 이렇게 쓰기 불편하니까 타입 어노테이션으로
    let random: [UIColor] = [.blue, .brown, .red, .orange, .white, .purple, .yellow]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .green
        configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        // viewDidLoad에 쓴 것과 보여지는 것의 차이는 없지만 화면을 왔다갔다할 때마다 계속 덮이면서 쓰이고 있다
        // 어디에 코드를 쓸지 생각하고 넣어야 한다
//        view.backgroundColor = .green
        
        // 왔다갔다할 때마다 랜덤으로 색을 주고싶다면 여기에 넣는게 맞음
        view.backgroundColor = random.randomElement()
        // 화면이 미리 바뀌어있음
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        // 화면이 완벽히 뜨고 난 다음에 변경됨
    }
    
    // main view로 돌아오는 코드 (터널)
    // 스토리보드에서 당겨서 만드는 코드 아님! 직접 코드 작성!
    // Exit
    @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
        print("TamaMainViewController로 돌아왔어요")
    }
    
    
    // 네비게이션에 속성을 주는 함수이름인데
    // 이 안에 랜덤으로 뽑아주는 기능이 있을 것이라고는 상상도 못한다
    // 하나의 함수에 하나의 기능만 넣어두자
    func configureNavigationItem() {
        navigationItem.title = "\(getRandomNickname())님의 다마고치"
        // 기능 실행하고 반환값을 사용하는 것, 이 함수의 타입은 리턴 타입과 일치 (String)
        
        return
        // 이 return 키워드가 생략되어 있는 것임
        // 원래는 있는데 굳이 쓸 필요 없으니까 생략
        // 필요할 때는 명시적으로 사용
    }
    
    func getRandomNickname() -> String {
        var nick = ["a", "b", "c", "d", "e"]
        
//        nick.removeAll()  // 경우에 따라서 nil값이 나올 수 있기 때문에 옵셔널타입
        let random = nick.randomElement() ?? "대장"  // !
        // 마찬가지로 randomElement()도 함수인데 String을 꺼내줌
        
        /*
        if random == nil {
            navigationItem.title = "대장님의 다마고치"
        } else {
            // 앞에서 nil을 걸러주니까 무조건 nil이 안나옴
            navigationItem.title = "\(random!)님의 다마고치"
        }
         */
        
//        return random
        // Code after 'return' will never be executed
        
        print(random)
        // 출력은 가능한데 이 random상수를 configureNavigationItem()에 보내주고 싶다
        // print로 찍을 수 있으면 개발자만 볼 수 있는 게 아니라 사용자까지 볼 수 있게 확장해줄 수 있다: 반환값
        return random
        // return은 엔터로 끝내는 것처럼 진짜 끝내는 것이다
    }
}
