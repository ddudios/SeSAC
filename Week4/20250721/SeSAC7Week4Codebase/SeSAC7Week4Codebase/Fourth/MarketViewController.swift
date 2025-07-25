//
//  MarketViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

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

// 서버 통신 결과를 테이블뷰에 보여주고 싶다
    // 배열을 테이블뷰에 보여주고 싶다
class MarketViewController: UIViewController {
    
//    var list: [String] = ["비트코인", "이더리움", "리플", "도지코인"]
    var list: [Coin] = [
        Coin(market: "비트코인", korean_name: "코인", english_name: "Coin"),
        Coin(market: "이더리움", korean_name: "이더", english_name: "Eth"),
        Coin(market: "비트코인", korean_name: "비트", english_name: "BTC")
    ]
    
    // 이름없는함수 실행할 수 있는 환경(즉시실행함수) (엄청 선호하는 방식은 아님)
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        
        // 같은 시점에 어떻게 만들어 -> 테이블뷰를 조금 늦게 만ㄷ르자
        tableView.delegate = self
        tableView.dataSource = self  // self == 인스턴스, MarketViewController인스턴스에 있는 tableView에 접근
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
        return tableView
    }()

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
        
        callRequest()
        print("CallRequest 메서드 이후")
        configureHierarchy()
        configureLayout()
        configureView()
        
//        callBoxOffice()
    }
    
    func callRequest() {
        print(#function, "첫번째")
        // 문서에서 보고 복붙
        let url = "https://api.upbit.com/v1/market/all"
        // responseString으로 서버에서 잘 뜨는지 먼저 확인 후 이 코드 사용 (최소한의 디버깅)
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: [Coin].self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                print("success", value)
                
                // list에 내용을 담고
                // 테이블뷰 갱신
                self.list = value
                self.tableView.reloadData()  // 네트워크 통신이 끝난 이후에 실행: 성공했을 때만 내용을 담아주고 -> 데이터가 바뀌었으니까 갱신
                
                print(value[2].korean_name)
                print(value[2].english_name)
                print(value[2].market)
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
    }
    
    func callBoxOffice() {
        // http(X) -> ats 대응 (https로 사이트에서 대응하지 않았으면 안된다)
            // "가 중간에 나오면 String이 끝나버리기떄문에 \"처리를해서 \가 많이 들어있는 것임
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=5b169fc7c3f7c25eda2c695ea9a970d6&targetDt=20200808"
        // responseString으로 서버에서 잘 뜨는지 먼저 확인 후 이 코드 사용 (최소한의 디버깅)
        AF.request(url, method: .get).validate(statusCode: 200..<300)
//            .responseString { resonse in
//            print(resonse)
            .responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                print("success", value)
                dump(value)
                print(value.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
            case .failure(let error):
                print("fail", error)
            }
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // Literal한 값을 뷰컨에서 안보이도록 만들자
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        cell.backgroundColor = .blue
        let row = list[indexPath.row]
        cell.nameLabel.text = row.coinOverview
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
    }
}

//struct Mentor2 {
//    let hello = "dfa"  // 인스턴스 프로퍼티
//    static let welcome = "ㅇㅁㄹ"  // 타입 프로퍼티
//}
