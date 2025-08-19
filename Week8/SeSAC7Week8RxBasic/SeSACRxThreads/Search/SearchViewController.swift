//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    let disposeBag = DisposeBag()  // BaseViewController에 넣을 수 있음
   
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    
//    let items = Observable.just(["First Item", "Second Item", "Third Item"])  // just내부값을 꺼내기 어려워서 변형
    let data = ["First Item", "Second Item", "Third Item"]
    lazy var items = Observable.just(data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        operatorTest()
    }
    
    func bind() {
        print(#function)
        
        // 그냥 복사해서 사용하면 됨 (이것저것 생략됨)
        items  // observable
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            cell.appNameLabel.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        /*
        // 둘 다 didSelectRowAt인데 하나는 indexPath만, 하나는 data만
        tableView.rx.itemSelected  // cell클릭시 뭐해줄거에요? - 이벤트 발생  // observable
            .bind(with: self) { owner, indexPath in  // 셀 클릭이 실패할리 없으니까 그냥 bind - 수습
                print(indexPath)
//                print(owner.data[indexPath.row])
            }
            .disposed(by: disposeBag)
        // IndexPath 가져오는 오퍼레이션 따로
        // 데이터 가져오는 오퍼레이션 따로
        tableView.rx.modelSelected(String.self)  // observable
            .bind(with: self) { owner, value in
                print(value)  // 위에서 let, lazy var를 사용할 필요없이 선택한 셀에 어떤 데이터가 들어있는지 가져옴
            }
            .disposed(by: disposeBag)
        // 지금 이 코드는 셀을 두번 클릭한것과 같은 느낌 -> 나중에 개선
        */
        /*
        // Observable을 하나로 그룹화
        Observable.zip(  // 둘을 하나로 합치는 일을 벌림
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )  // 순서대로 매개변수가 들어옴
        .bind(with: self) { owner, tableView in
            print(tableView.0)
            print(tableView.1)
        }
        .disposed(by: disposeBag)
        */
        // 처음엔 괜찮은데 두번째부터 2번 눌림
        Observable.combineLatest(  // 둘을 하나로 합치는 일을 벌림
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )  // 순서대로 매개변수가 들어옴
        .bind(with: self) { owner, tableView in
            print(tableView.0)
            print(tableView.1)
        }
        .disposed(by: disposeBag)
        /**
         .zip Vs. .combineLatest (Rx는 비교하면서 공부하기)
         - zip: 두 옵저버블이 모두 변화할 때 이벤트가 방출됨
         - combineLatest: 두 옵저버블 중 하나만 바껴도 이벤트가 방출됨
         */
    }
    
    func operatorTest() {
        let mentor = Observable.of("Hue", "Jack", "Finn")  // 가변 매개변수로, 여러 개 들어갈 수 있음
        let age = Observable.of(10)
        
        Observable.zip(
            mentor,
            age
        )
        .bind(with: self) { owner, value in
            print(value)
        }
        .disposed(by: disposeBag)
        /**
         # zip: 각각의 Observable mentor, age 둘 다 변화가 생길 때, 이벤트 방출
         ("Hue", 10)
         */
        
        Observable.combineLatest(
            mentor,
            age
        )
        .bind(with: self) { owner, value in
            print(value)
        }
        .disposed(by: disposeBag)
        /**
         ("Hue", 10)
         ("Jack", 10)
         ("Finn", 10)
         */
    }
     
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(plusButtonClicked))
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
