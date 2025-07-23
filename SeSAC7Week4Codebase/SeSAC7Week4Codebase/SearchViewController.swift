//
//  SearchViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/22/25.
//

import UIKit
import SnapKit

// 프로토콜: 부하직원처럼 만들어줌 (ex)UICollectionViewDataSource
class SearchViewController: UIViewController {
    // protocol에서 가져온 프로퍼티
        // extension에서 하면 안됨
//    var myTitle: String = "검색 화면"
    var myTitle: String {
        get {
            return "검색 화면"
        }
        set {
            print(newValue)  // 추가적으로 만들어줄 수는 있지만 없어도 됨
        }
    }
    
    // 저장/연산 프로퍼티로 가져올 지는 구현부에서 정함
//    var myButton: String = "save"  // 저장프로퍼티(get, set 모두 가능)
    var myButton: String {  // 연산프로퍼티로도 사용할 수 있음
        get {
            return "save"  // 다짜고짜 스트링을 가져옴
        }
        set {  // 셋팅 필수
            
        }
    }
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
//        myTitle = "고래밥의 화면"  // 가져오는 것만 명세했는데 셋팅이 가능하다
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    /*
    // 이름만 만들어 놓은 것에 구현부는 다 다르게 들어갈테니까 이 프로토콜에서는 뭐가 필요한지 이름만 지정해두고, 이름 안에 들어가는 내용은 부하직원을 거느리는 구현부에서 처리를 한다.
    // 뷰컨이 아무리 많아도 역할에 맞게 코드를 구성해주기만 하면 된다
    // 무조건 필요한 것들은 써줘야 오류가 나지 않음
    
    // 코드의 위치를 강제화: 하이라키에 에드서브뷰 넣고, ...
    func configureHierarchy() {
        view.addSubview(label)
    }
    
    func configure() {
        <#code#>
    }
    
    func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
    }
    
    func configureView() {
        view.backgroundColor = .lightGray
        label.backgroundColor = .orange
    }*/
    // 이 메서드가 누구의 프로토콜에서 나온지 모른다 -> extension으로 처리
}

// 같은 소속으로 넣으면 구조가 잡혀있어서 알아보기 쉽다 (extension)
extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}

extension SearchViewController: JackNavigationProtocol {
    // extension은 저장프로퍼티는 쓸 수 없음 (연산프로퍼티는 가능)
        //
//    var hello = "고래밥"
    
    func configure() {
        navigationItem.title = myTitle
    }
}

/*
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}*/

/*
 // 클래스 내의 모든 프로퍼티는 반드시 초기화가 되어야 한다. 그래야 인스턴스를 만들고 접근해서 사용할 수 있다
class User {
    let name: String = ""
    let age: Int = 0
}
 
 // extension에 User가 들어가 있으면, 클래스의 인스턴스에서 추가로 만들어지는 거기 때문에 인스턴스가 생성되는 범위에 대한 한계점이 필요하지 않을까
 // extension은 말 그대로 확장이기 때문에 써도되고 안써도 된다
 // 확장은 내 기능에서 +알파인 건데 저장프로퍼티는 User라는 인스턴스가 생성이 될 때 무조건 초기화가 되어야 하는 요소이기 때문에 저장프로퍼티는 extension안에 넣지 말기
// 인스턴스 관점에서는 적절한 위치가 아님
extension User {
//    let example: String
}

// UIViewController를 확장해서 사용하면, UIViewController를 상속받는 모든 ViewController한테 다 적용될 수 있게 해주는 건데 만약 여기에 저장프로퍼티가 있다면 모든 UIViewController에 이 친구에 대한 인스턴스를 만들어줘야 한다 그러면 그것도 이상하다
extension UIViewController {
    func setBackgroundColor() {}
}
 
 // 왜 extension에서는 저장프로퍼티를 포함할 수 없을까?
 // 말 그대로 확장 기능이기 때문에 SearchViewController의 인스턴스의 관점에서는 적당한 위치가 맞을까에 대한 고민을 하다보면 스스로 결론을 내릴 수 있을 것이다
 
 */

/*
 이전 강의자료 참고
 리펙토링의 목적은 문법 적용
 */
