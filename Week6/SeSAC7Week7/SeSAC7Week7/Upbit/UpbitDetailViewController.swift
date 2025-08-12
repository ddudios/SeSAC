//
//  UpbitDetailViewController.swift
//  SeSAC7Week7
//
//  Created by Suji Jang on 8/12/25.
//

import UIKit

class UpbitDetailViewController: UIViewController {
    
    // 디테일뷰컨도 뷰모델이 필요한 순간이 있지 않을까?
        // 뷰컨마다 뷰모델이 있을 수 있다
//    var koreanData: String?
    let viewModel = UpbitDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        navigationItem.title = "test" //koreanData ?? "" //"상세 화면"
        // 옵저버블을 사용하면 뷰디드로드시점이 아닌, 값이 변경될 때마다 변경해줄 수 있음
        viewModel.outputTitle.bind {
            let data = self.viewModel.outputTitle.value
            self.navigationItem.title = data
            print("outputTitle Bind, \(data)")
            // viewController로 로직을 옮기니 print가 되지 않음
                // didSet에 들어가만 있고 실행은 되지 않은 상태, 바로 실행시키려면 ReviewObservable에서 바로 실행하는 코드를 추가해줘야 한다 (셋팅만 된거지, 값이 바뀌어야 action이 실행됨)
                // bind로 전달한 함수를
                // -> 바로 실행도 하고, didSet action에 넣어둘 지
                // -> 실행하지 않고 didSet action에 넣어둘 지
        }
        // 실행시켜주려면 데이터를 받은 다음에 값변경까지 해줘야 액션 실행
        viewModel.outputTitle.value = "받은 데이터를 표시하지 못함"
        // 바인드 구문이 실행되면서 이전에 전달받은 데이터는 없고 바꿔둔 데이터 "받은 데이터를 표시하지 못함"를 표시하고 처음 할당받은 데이터는 뷰에 보이지 않는 문제가 생길 수 있다
        // 바인드에 들어있는 내용이 값이 바뀌지 않더라도 didSet이 처음에 실행안되더라도 실행될 수 있는 환경으로 만들어줘야 하고, 바로 실행 + 할당하려면 옵저버블 바인드에서 실행해줘야 한다
    }
}
