//
//  SettingViewController.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

//extension UIViewController {
//protocol JackProtocol {
//    associatedtype Item
//    
//    func total(a: Item, b: Item)
//}
//
//class Test: JackProtocol {
//    func total(a: Item, b: Item) {
//        <#code#>
//    }
//}

struct JackSection {
    
    /**
     public protocol SectionModelType {
         associatedtype Item

         var items: [Item] { get }

         init(original: Self, items: [Item])
     }
     */
    
    let header: String
    var items: [String]
    
    // struct는 기본적으로 initializer를 선언해주지 않아도 멤버와이저이니셜라이저를 제공해준다
//    init(header: String, items: [String]) {
//        self.header = header
//        self.items = items
//    }
    
    // 그런데 매개변수명을 변경하는 순간 자동으로 나왔던 멤버와어지이니셜라이저는 사라지게 된다
//    init(a: String, items: [String]) {
//        self.header = a
//        self.items = items
//    }
    
    // 그래서 안쓰면 안썼지 이 init을 다른 형태로 변경해서 사용하는 순간, 자동으로 썼던 부분이 사라지게 된다
    // SectionModelType을 선언해뒀더니 init을 꼭 써야 하는데, header와 items를 자동으로 가지고 있던 구문이 덮어씌워져서 쓸 수 없게됨
//    init(original: JackSection, items: [String]) {
//        <#code#>
//    }
}
// 이런 문제를 해결하기 위해서 SectionModelType을 구조체에 바로 채택하지 않고 extension으로 만든다
// init은 extension에서 만들어지고, 본래 struct에서 initializer구문을 지켜낼 수 있다
    // 왜 굳이 extension으로 따로 만들어서 처리했을까?
    // - header, items를 넣을 수 있는 initializer도 같이 쓰고 싶어서 protocol을 나눠서 쓸 수 있음
extension JackSection: SectionModelType {
    init(original: JackSection, items: [String]) {
        self = original
        self.items = items
    }
}

class SettingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    private let items = Observable.just(["a", "b", "c"])
    
    private let list = [
        JackSection(header: "전체 설정", items: ["공지사항", "실험실"]),
        JackSection(header: "개인 설정", items: ["알림", "채팅", "프로필"]),
        JackSection(header: "기타", items: ["고객센터", "도움말"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        bind()
        
//        list[2].header  // "기타"
//        list[2].list[0]  // "고객센터"
    }
    
    private func bind() {
        // 코드 구조: 기존에 사용하던 것에는 클로저가 길게 들어가 있었는데 이 부분이 데이터소스로 빠져버림
        //        items
        //        .bind(to: tableView.rx.items) { (tableView, row, element) in
        //            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        //            cell.appNameLabel.text = "\(element) @ row \(row)"
        //            return cell
        //        }
        //        .disposed(by: disposeBag)
        
        // 이 상수에 모든 코드를 넣어준다
        // 이 상수가 잘 만들어져있다면 연결
        let dataSource = RxTableViewSectionedReloadDataSource<JackSection>(configureCell: { (dataSource, tableView, indexPath, item) in
            // (제네릭 구조에 누가 들어오는지 명세: 그래서 보통 클래스를 생성할 때 제네릭 내부에 SectionModelType을 채택하고 있는 JackSection데이터를 기준으로 뿌려줄거야 라고 제네릭에 타입을 명세
            /**
             open class RxTableViewSectionedReloadDataSource<Section: SectionModelType>  // 클래스의 이니셜라이저로 만들 수 있음 <제네릭구조: 제네릭에는 SectionModelType프로토콜을 채택했다면 들어올 수 있음>
                 : TableViewSectionedDataSource<Section>
                 , RxTableViewDataSourceType {
                 public typealias Element = [Section]

                 open func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
                     Binder(self) { dataSource, element in
                         #if DEBUG
                             dataSource._dataSourceBound = true
                         #endif
                         dataSource.setSections(element)
                         tableView.reloadData()
                     }.on(observedEvent)
                 }
             }
             */
            
            // 제네릭 구조를 굳이 명세하지 않고 사용: 타입어노테이션으로 써주면 가능 -> 너무 많이 중복되니까 애초에 내부에 제네릭을 써버리는 형태로 사용
//        let dataSource: RxTableViewSectionedReloadDataSource<JackSection> = RxTableViewSectionedReloadDataSource(configureCell: <#T##(TableViewSectionedDataSource<JackSection>, UITableView, IndexPath, String) -> UITableViewCell#>)
            
            // 나머지는 클로저 구문으로 이루어져 있어서 이 블럭이 잡혀져 있으면 configureCell이 가지고 있는 형태를 만들어주면 된다
                // 어떤 셀을 쓰겠다
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            
                // 각각의 셀이 가지고 있는 것 사용
            cell.appNameLabel.text = item
            return cell
            
           // 각 섹션마다 다른 셀을 사용할 수 있으니까 굳이 RxDataSource 사용
        })
        
        // 데이터소스는 이런 형식으로 사용 - 사용하고 싶은 것은 문서에서 찾아서 그대로 사용
        dataSource.titleForHeaderInSection = { dataSource, index in
//            return self.list[index].header  // self기재로 인해서 메모리 누수 가능성
            
            // 매개변수 dataSource는 JackSection에 해당하는 모든 정보를 다 갖고 있어서
            // list 배열에서 직접적으로 조회하지 않아도 dataSource를 통해서 클래스에 접근하면 이 클래스를 통해서 sectionModels에 접근할 수 있다 (오픈소스에서 지원해주는 문서를 보고 사용하면 됨 -> 참조이슈, 캡쳐이슈 없이 지원해주는 데이터소스를 통해서 사용할 수 있다)
            return dataSource.sectionModels[index].header
        }
        
        Observable.just(list)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
