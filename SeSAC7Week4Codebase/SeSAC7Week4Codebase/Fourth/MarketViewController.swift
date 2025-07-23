//
//  MarketViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import SnapKit

/*
@objc protocol Mentor1 {
    @objc optional func hello()
}
// 어디든 적용되는 것이 프로토콜
// AnyObject를 붙이면 class에만 한정되는 것이니까 그게 없으니까 돼야할텐데 objc는 구조체가 없어서 (클래스만 있었음) 핸들링할 수 없다

class Den: Mentor1 {
    
}

struct Finn: Mentor1 {
    
}*/

//class SeSAC {}
//class Jack: SeSAC {}
//class Bran: SeSAC {}
//class Hue {}
//struct Finn {}  // struct는 상속 불가능
//struct Den {}

protocol Mentor3 {}
class SeSAC {}
class Jack: SeSAC {}
class Bran: SeSAC, Mentor3 {}
class Hue: Mentor3 {}
struct Finn: Mentor3 {}
struct Den {}

class MarketViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 타입이 다르면 못들어온다
//        var mentor: Jack = Jack()
//        let a = Jack()
//        let b = Bran()
//        let c = Finn()
//        mentor = a  // 같은 타입이 들어갈 수 있음
//        mentor = b  // 다른 타입은 들어갈 수 없음
//        mentor = c
        
        //2. 부모 클래스에는 자식 클래스가 들어갈 수 있다
//        present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)  // UIViewController만 들어가야 하는데 그를 상속받은 MarketViewController 자식이 들어갈 수 있음
//        var mentor: SeSAC = Jack()  // 부모클래스가 자식을 품을 수 있다
//        let a = Jack()
//        let b = Bran()
//        let c = Hue()
//        let d = Finn()
//        mentor = a  // 같은 타입이 들어갈 수 있음
//        mentor = b  // 상속받은 클래스는 들어갈 수 있음
//        mentor = d  // 상속받지 않은 클래스는 들어갈 수 없음
//        mentor = c  // struct는 들어갈 수 없음
        
        //3. 타입으로서의 기능을 하는 프로토콜의 특성 활용
//        var mentor: Mentor3 = Jack()  // 채택하지 않아서 들어갈 수 없음
//        var mentor1: Mentor3 = Finn()
//        let a = Den()
//        let b = Hue()
//        mentor1 = a
//        mentor1 = b
        
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        cell.backgroundColor = .blue
        return cell
    }
}

extension MarketViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        self.tableView.dataSource = self  // self == 인스턴스, MarketViewController인스턴스에 있는 tableView에 접근
        // MarketViewController: UITableViewDelegate, UITableViewDataSource에서 채택하지 않으면 에러: 클래스가 그 프로토콜을 가지고 있지 않아서 타입으로서의 프로토콜이 되고 있지 않음
        // 프로토콜의 기능 중 하나가 타입처럼 사용할 수 있다
        
//        let xib = UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>)  // xib파일명을 가져옴
        // 코드 기반으로 가져옴
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.self.identifier)
        // self는 MarketViewController클래스의 인스턴스와 상관없음
        // 여기서의 self는 이 MarketTableViewCell클래스 자체
        // 클래스 자체의 무언가를 가져올 때는 생략가능하지만 그 자체를 가져올 때는 생략하면 안됨
//        Mentor2().hello
//        Mentor2.self.welcome
    }
}

//struct Mentor2 {
//    let hello = "dfa"  // 인스턴스 프로퍼티
//    static let welcome = "ㅇㅁㄹ"  // 타입 프로퍼티
//}
