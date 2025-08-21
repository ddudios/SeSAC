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
//    var data = ["First Item", "Second Item", "Third Item"]
//    lazy var items = Observable.just(data)  // 초기화가 될 때 가지고 있을 뿐, data가 들어오고 items는 끝남
//    lazy var items = BehaviorSubject(value: ["First Item", "Second Item", "Third Item"])  // Observable의 역할을 하기 때문에 subscribe, bind 써도됨
//    Observable.just(["First Item", "Second Item", "Third Item"])  // 전달만 할 수 있는데, 받아서 처리까지 하고싶음
    /**
     옵저버블 -> 옵저버
     items -> tableView
     셀클릭 -> print
     items가 data를 가지고 있으니까 data가 바뀌면 items도 바뀔거라는 꿈을 꾸면 안된다
     셀 클릭시 items.append하는 기능까지 하고 싶음: items는 Observable이자 Observer인 Subject
     */
    var den = "den"
    lazy var jack = den  // den을 바꿨다고 jack이 알아서 바뀌진 않음
    
//    let items = BehaviorSubject(value: ["First", "A", "AB", "BC", "BCD", "First", "AF"])
    var data = ["김새싹", "고래", "고래밥", "a", "hhhha", "a고래밥", "호", "ㅕㅑㅕㅑ", "ㄴㅇㄹㅁ", "하하", "호호", "히히"]
    lazy var items = BehaviorSubject(value: data)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        operatorTest()
        
        den = "asdf"
    }
    
    func bind() {
        print(#function)
        /*
//        searchBar.rx.searchButtonClicked
//            .map { "닉네임: "}
//            .withLatestFrom(searchBar.rx.text.orEmpty) { nickname, text in
//                return nickname + text
//            }
        
        // 서치바에 입력 후 엔터 치면 배열에 데이터 추가
        searchBar.rx.searchButtonClicked  // 여기까지가 Observable
//            .withLatestFrom(searchBar.rx.text.orEmpty) { _, text in  // withLatestFrom전 데이터, withLatestFrom(searchBar.rx.text.orEmpty)
//                return text
//            }
            .withLatestFrom(searchBar.rx.text.orEmpty)  // 같은 내용이니까 생략 가능
            .bind(with: self) { owner, value in
                print(value)
                owner.data.insert(value, at: 0)
                owner.items.onNext(owner.data)
//                owner.items.on(.next(owner.data))
            }
            .disposed(by: disposeBag)
        */
        
        // 실시간 검색
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)  // 1초동안 기다려도 아무 동작이 없으면 실행: ㄱ 고 (ㄱ은 검색되지 않게)
            .distinctUntilChanged()  // 데이터가 바뀌지 않았으면 방출되지 마라
            .bind(with: self) { owner, value in
                print(value)
                
                // 내용 비어있으면 전체 보여주고 있으면 필터링
                let filter = value.isEmpty ? owner.data : owner.data.filter { $0.contains(value) }
                
                owner.items.onNext(filter)
                
            }.disposed(by: disposeBag)
        
        // 그냥 복사해서 사용하면 됨 (이것저것 생략됨)
        items  // observable
        .bind(to: tableView.rx.items) { (tableView, row, element) in  // CellForRowAt
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            cell.appNameLabel.text = "\(element) @ row \(row)"
            cell.downloadButton.rx.tap
                .bind(with: self) { owner, _ in
                    print("클릭되었습니다")
                    let vc = DetailViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)  // 구독 중첩: 여러번 스크롤할수록 화면전환이 더 많이 일어남
                }
//                .disposed(by: self.disposeBag)  // 클로저 안에 들어있기 때문에 self써라, owner밖에 있음
                .disposed(by: cell.disposeBag)  // 셀이 해제되면 구독 해제 (cell에서 관리하도록 만듦)
            
            return cell
        }
        .disposed(by: disposeBag)
        
        Observable.zip(  // 둘을 하나로 합치는 일을 벌림
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )  // 순서대로 매개변수가 들어옴
        .bind(with: self) { owner, tableView in
            print(tableView.0)
            print(tableView.1)
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
        /*
        // 처음엔 괜찮은데 두번째부터 2번 눌림
        Observable.combineLatest(  // 둘을 하나로 합치는 일을 벌림
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(String.self)
        )  // 순서대로 매개변수가 들어옴
        .bind(with: self) { owner, tableView in
            print(tableView.0)
            print(tableView.1)
//            owner.data.append("고래밥 \(Int.random(in: 1...100))")
//            owner.tableView.reloadData()  // 데이터 추가됐는데 왜 셀에 표시되지 않지?
            /**
             items가 배열이었다면 그냥 추가하면 됐는데 items.append("adfs")
             1. 배열이 아니기 때문에 append를 할 수 없다
             2. 옵저버블의 특성 때문에 애초에 말이 안되는 행동을 하고 있다 (옵저버블의 역할은 일을 벌려서 이벤트를 주는 것밖에 못함, 받아서 뭔갈 하는 거는 할 수 없음, 클릭만 할 수 있지) 옵저버블은 전달만 할 수 있지 뭔가를 받아서 처리해줄 수 없음
             (이벤트를 전달도 하고 받기도 했으면 좋겠다)
             모든 것은 이벤트를 통해서 전달한다
             */
//            print(owner.data)
//            owner.items.onNext(["asfd"])  // items에 이벤트를 전해달라: 셀클릭시 이 데이터로 변경됨
        }
        .disposed(by: disposeBag)
        /**
         .zip Vs. .combineLatest (Rx는 비교하면서 공부하기)
         - zip: 두 옵저버블이 모두 변화할 때 이벤트가 방출됨
         - combineLatest: 두 옵저버블 중 하나만 바껴도 이벤트가 방출됨
         */
        
        
        /*
        // delegate만들지 않아도 됨
        searchBar.rx.searchButtonClicked
            .subscribe(with: self) { owner, _ in
                print("클릭")
                /**
                 1. 서치바 글자 가져오기 items observable -> searchBar Observer / searchBar Click Observable -> items Observer
                 2. items에 글자를 추가
                 */
                guard let text = owner.searchBar.text else { return }
//                items.append(text)
                var result = try! owner.items.value()  // 기존 데이터 조회: BehaviorSubject(value: ["First"]): [String]
                result.append(text)
                
//                owner.items.onNext([text])  // 보내는 거고 Observable은 받을 수 없기 때문에 Subject로 변경: 통으로 전달해서 append가 아니라 기존 데이터에 덮어씌워짐
                owner.items.onNext(result)
            }
            .disposed(by: disposeBag)
*/
        searchBar.rx.text.orEmpty  // 실시간 텍스트필드 글자 가져옴
            .debounce(.seconds(1), scheduler: MainScheduler.instance)  // 타이밍 조절: 검색어 입력 후 몇초 뒤 검색 (콜 횟수 줄임)
            .distinctUntilChanged()  // 썼다 지웠다 하면 같은 키워드가 여러번 검색됨 - 어려운 기능들도 어떤 Operator가 있는지 알면 그냥 구현해버릴 수 있음
            .subscribe(with: self) { owner, value in
                print("searchbar text", value)
                
                let all = try! owner.items.value()
                let filter = all.filter { $0.contains(value) }
                // ㅇ call 어 call 업 call 어베 call 불필요한 call 많이 들어감, 최종 어벤 전에 불필요한 데이터가 들어갈 수 있어서 debounce 기능 사용
                print(filter)
            }
            .disposed(by: disposeBag)
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
