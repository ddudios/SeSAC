//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

final class HomeworkViewController: UIViewController {
    
    // 일단 다 붙이고 정말 필요할 때 덜어내기 final, private
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
    
    private let disposeBag = DisposeBag()
    
    // 20.
    /*
//    let list = Observable.just([1,2,3,4,5])  // 이벤트 전달만
//    let list = PublishRelay<[Int]>()
//    let list: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    let list: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])
    
//    let items = Observable.just(["a","b","c"])
    // Observable + Observer 이벤트 받을 수 있도록 변경
    let items = BehaviorRelay(value: ["a", "b", "c"])  // 실패 케이스를 거의 만날 일이 없으니까 자주 사용
     */
    
    // 5.
//    let viewModel = HomeworkViewModel()
    // 뷰컨이 뷰모델을 다 가지고 있는 형태: 뷰컨이 뷰모델을 안가지고 있게끔 개선
    private let viewModel: HomeworkViewModel
    
    init(viewModel: HomeworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        
        // 6.
        let input = HomeworkViewModel.Input(searchTap: searchBar.rx.searchButtonClicked, searchText: searchBar.rx.text.orEmpty/*, cellSelected: tableView.rx.modelSelected(Int.self)*/, cellSelected: tableView.rx.modelSelected(Lotto.self))  // 11. 17.
        let output = viewModel.transform(input: input)
        
        
        // 7. output. -> 확인: transform을 통해서 output data 잘 넘어옴
        output.list  // Observable
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)) { (row, element, cell) in  // Observer: 이벤트 처리
//                cell.usernameLabel.text = "셀 \(element)"
                let text = "\(element.drwNoDate)일, \(element.firstAccumamnt.formatted())원"
                cell.usernameLabel.text = text
            }
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { (row, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        
        output.showAlert
            .bind(with: self) { owner, value in
                if value {
                    print("네트워크 실패 발생 >>> 얼럿을 띄워주세욤")
                }
            }
            .disposed(by: disposeBag)
        
        
        // 20. 옮겨서 그런걸까? 여전히 오류가 남
        /*
            // list: BehaviorRelay<[Lotto]>
            // 각 셀에 들어있는 정보의 타입을 일치시켜줘야 한다
//        tableView.rx.modelSelected(Int.self)
        tableView.rx.modelSelected(Lotto.self)
            .map { "셀 \($0)" }
            .bind(with: self) { owner, number in
                print(number)
            }
            .disposed(by: disposeBag)
         */
        
        
        // 14. output을 뱉어주고 있으니 input으로 들어갈 수 있겠다
        /*
        /*let a = */tableView.rx.modelSelected(Int.self)  // Observable
            .map { "셀 \($0)" }
            .bind(with: self) { owner, number in
                var original = owner.items.value  // Relay쓰면 이벤트 줄어들고 오류를 위한 do-catch가 없으니까 try구문도 안써도됨 (Subject -> try)
                // value == return try! self.subject.value()
                // subject로 랩핑되어 있음 (내부에서는 결국 try!)
                // 사실상 간편하게 만들어준 프로퍼티밖에 안된다.. 그래도 try!를 써도 되니까 이렇게 만든거 아닐까!
                original.insert(number, at: 0)
                owner.items.accept(original)  // onNext -> accept (어떻게 items로 들어가는거지? onNext는 이벤트 방출,..)
            }
            .disposed(by: disposeBag)
         */
        
        
        // 8. input: 서치버튼 클릭, 글자 들어옴
        /*
        searchBar.rx.searchButtonClicked  // 이 SearchButtonClicked 옵저버블은 계속 살아있고
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in  // 스트림이 흘러가면서 자식 옵저버블 핸들링할 수 있음
                // 이 내부에서 lottoAPI 호출 -> next이벤트 얻어서 -> 부모한테 전달
                CustomObservable.getLotto(query: text)  // 네트워크 통신
                // 부모옵저버블 안에 자식 옵저버블이 계속 생겨나는 중
                    .debug("로또 옵저버블")
            }
            .debug("서치바 옵저버블")  // 옵저버블이 끝나는 지점에 debug찍음
        /**
         #실행하자마자
         2025-08-25 12:21:07.393: 서치바 옵저버블 -> subscribed  #HomworkVC꺼지지 않는 이상 살아있음
         
         #엔터시
         2025-08-25 12:21:41.411: 로또 옵저버블 -> subscribed
         2025-08-25 12:21:41.581: 로또 옵저버블 -> Event next(Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640))  #이벤트 방출
         2025-08-25 12:21:41.581: 서치바 옵저버블 -> Event next(Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640))  #부모한테 넘겨주고 있음
         onNext Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640)  #부모의 넥스트이벤트까지 잘 방출됨
         
         #또 엔터시
         2025-08-25 12:22:33.431: 로또 옵저버블 -> subscribed  #새로운 옵저버블 생성
         2025-08-25 12:22:33.524: 로또 옵저버블 -> Event next(Lotto(drwNoDate: "2024-12-14", firstAccumamnt: 26700545253))  #부모한테 이벤트 방출
         2025-08-25 12:22:33.524: 서치바 옵저버블 -> Event next(Lotto(drwNoDate: "2024-12-14", firstAccumamnt: 26700545253))  # 부모는 받아서 방출
         onNext Lotto(drwNoDate: "2024-12-14", firstAccumamnt: 26700545253)  #잘표시
         
         #dispose되지 않아서, 이제 전에 생성된 새로운 자식 옵저버블들은 지울 수 없음
         #매번 호출하고 컴플릿하도록 만들어야한다
         2025-08-25 12:24:54.874: 서치바 옵저버블 -> subscribed  #서치바구독
         2025-08-25 12:25:02.012: 로또 옵저버블 -> subscribed  #1000회차 입력후 엔터 -> 로또옵저버블 구독
         2025-08-25 12:25:02.245: 로또 옵저버블 -> Event next(Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640))  #로또 이벤트 받고있음
         2025-08-25 12:25:02.245: 서치바 옵저버블 -> Event next(Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640))  #서치바 이벤트 받고 있음
         onNext Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640)  #
         2025-08-25 12:25:02.246: 로또 옵저버블 -> Event completed  #컴플릿받으니까
         2025-08-25 12:25:02.246: 로또 옵저버블 -> isDisposed  #리소스 정리
         #다시 엔터
         2025-08-25 12:26:35.243: 로또 옵저버블 -> subscribed
         2025-08-25 12:26:35.328: 로또 옵저버블 -> Event next(Lotto(drwNoDate: "2023-12-30", firstAccumamnt: 28698481136))
         2025-08-25 12:26:35.328: 서치바 옵저버블 -> Event next(Lotto(drwNoDate: "2023-12-30", firstAccumamnt: 28698481136))
         onNext Lotto(drwNoDate: "2023-12-30", firstAccumamnt: 28698481136)
         2025-08-25 12:26:35.329: 로또 옵저버블 -> Event completed
         2025-08-25 12:26:35.329: 로또 옵저버블 -> isDisposed
         
         next > completed > lotto disposed 너무 잘 해결
         #이상한 문자 입력시: error > lotto disposed / search disposed
         #에러가 부모한테까지 전파
         2025-08-25 12:28:06.474: 로또 옵저버블 -> subscribed
         2025-08-25 12:28:06.566: 로또 옵저버블 -> Event error(invalid)
         2025-08-25 12:28:06.566: 서치바 옵저버블 -> Event error(invalid)  // 자식의 에러를 부모가 받아오면서
         onError
         onDisposed
         2025-08-25 12:28:06.566: 서치바 옵저버블 -> isDisposed  #서치바까지 디스포즈
         2025-08-25 12:28:06.566: 로또 옵저버블 -> isDisposed
         #아무리 엔터를 쳐도 검색되지 않음
         # error > lotto disposed >부모까지 영향을 미쳐 search disposed
         # 오류 발생 이후에는 그래서 검색을 할 수 없게 됩니다. 왜냐하면 구독이 해제되었기 때문!
         # 이 부분은 내일 복습하면서 문제상황 인지+해결
         #오늘은: flatMap, networking, 부모옵저버블 안에 자식 옵저버블 다루는 방법
         */
            .subscribe(with: self) { owner, lotto in  // 네트워크 통신 결과 받아주는 곳
                // 자식한테 이벤트 받아서 부모는 내용 표시
                print("onNext", lotto)
                
                var data = owner.list.value
                data.insert(lotto, at: 0)
                
                owner.list.accept(data)  // accept에 data담아서 list에 보내줌
                
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        /**
         Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640)
         onNext Lotto(drwNoDate: "2022-01-29", firstAccumamnt: 27430031640)
         */
         */
    }
     /*
    private func bind통신을위한개념() {
        list  // Observable
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)) { (row, element, cell) in  // Observer: 이벤트 처리
                cell.usernameLabel.text = "셀 \(element)"
            }
            .disposed(by: disposeBag)
        
        items
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { (row, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Int.self)  // Observable
            .map { "셀 \($0)" }
            .bind(with: self) { owner, number in
                var original = owner.items.value  // Relay쓰면 이벤트 줄어들고 오류를 위한 do-catch가 없으니까 try구문도 안써도됨 (Subject -> try)
                // value == return try! self.subject.value()
                // subject로 랩핑되어 있음 (내부에서는 결국 try!)
                // 사실상 간편하게 만들어준 프로퍼티밖에 안된다.. 그래도 try!를 써도 되니까 이렇게 만든거 아닐까!
                original.insert(number, at: 0)
                owner.items.accept(original)  // onNext -> accept (어떻게 items로 들어가는거지? onNext는 이벤트 방출,..)
            }
            .disposed(by: disposeBag)
        
        /*
        searchBar.rx.searchButtonClicked
        // (#selector(UISearchBarDelegate.searchBarSearchButtonClicked(_:)) : 결국 애플의 코드를 랩핑
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .map { Int($0) ?? 0 }
            .bind(with: self) { owner, text in  // 문자 입력시 0이 들어옴
                print(text)
//                let a = owner.list.values  // Publish: AsyncThrowingStream<[Int], any Error> 비어있을 수 있으니까 가져오는데 에러가 있을 수 있고 생각보다 내가 원하는 형태로 가져오는게 불가능할 수도 있다 -> 간결하게 가져오고 싶어서 BehaviorRelay 사용하는 방법이 있다
                var data = owner.list.value
                data.insert(text, at: 0)
                owner.list.accept(data)
                
            }
            .disposed(by: disposeBag)
         */
        
        // 단순히 가지고 있는 문자 방출
//        Observable.just("A")
//            .bind(with: <#T##AnyObject#>) { <#AnyObject#>, <#String#> in
//                <#code#>
//            }
        // 랜덤으로 뽑는 기능 + 내부 구현은 숨기고 싶을 때
        CustomObservable.randomNumber()
            .bind(with: self) { owner, number in
//                print("number", number)
                owner.list.accept([number])  // owner가 가지고 있는 list에 [number]를 보여주겠다
            }
            .disposed(by: disposeBag)
        
        CustomObservable.recommandNickname()
//            .bind(with: self) { owner, nickname in
//            owner.items.accept([nickname])
    /**
     #bind는 error를 받을 수 없어서, 오류가 발생하면 런타임에러
     /Users/suji/Library/Developer/Xcode/DerivedData/SeSACRxThreads-ejfvffqelmveipeilxyqiihsnfgk/SourcePackages/checkouts/RxSwift/Sources/RxCocoa/Observable+Bind.swift:85: Fatal error: Binding error: invalid
     */
            .subscribe(with: self) { owner, value in
                owner.items.accept([value])
                print("onNext", value)
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        /**
         onNext 오예스  #onNext는 다음 것도 계속 받을 수 있음, 하지만 우리는 한번 방출하면 필요없기 때문에 CustomObservable 내부에 onCompleted()로 정리한다고 명시해줘야 한다 (오류는 나지 않지만 이 클래스가 종료될 때까지 계속 메모리에 남아있음)
         onNext 고래밥
         onCompleted
         onDisposed
         
         onError invalid
         onDisposed
         */
        
        // 커스텀 옵저버블을 활용해서, 서치 탭 시 랜덤으로 숫자를 추가
        /*
        searchBar.rx.searchButtonClicked
            .map { Int.random(in: 1...100) }
            .bind(with: self) { owner, number in
                var data = owner.list.value
                data.insert(number, at: 0)
                owner.list.accept(data)
            }
            .disposed(by: disposeBag)
        */
        /*
        searchBar.rx.searchButtonClicked
//            .CustomObservable.randomNumber()  // 클릭이벤트와 이 이벤트를 닷신텍스로 연결하기는 복잡해서 맵을 활용
            .map {
                CustomObservable.randomNumber()
                // 지금은 한줄짜리 코드라 위의 방법이 쉬워보이지만 AF.request 가 들어가면 엄청 길고 복잡해질 것이다
                // 매개변수로 Observable<Int>가 넘어옴
            }
            .bind(with: self, onNext: { owner, value in
                // value: Observable<Int>
                value  // Observable 안에 Observable이 있어서 또 bind해줘야 함, 순차적으로 꺼내주는 과정이 필요함
                    .bind(with: self) { owner, number in
                        var data = owner.list.value
                        data.insert(number, at: 0)
                        owner.list.accept(data)
                    }
                    .disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
         */
        /*
          searchBar.rx.searchButtonClicked  // Observable
              .map {
                  CustomObservable.randomNumber()  // 클릭할 때마다 Observable, Observable, ... 생성중
              }
              .bind(with: self, onNext: { owner, value in
                  value
                      .bind(with: self) { owner, number in
                          var data = owner.list.value
                          data.insert(number, at: 0)
                          owner.list.accept(data)
                      }
                      .disposed(by: owner.disposeBag)
              })
              .disposed(by: disposeBag)
         */
        // 로직은 같지만
        searchBar.rx.searchButtonClicked
//            .map {
//                return CustomObservable.randomNumber()  // Observable<Observable<Int>>
//            }
            .flatMap {  // Observable안의 Observable을 하나로 만들어주는 특성이 있음 Observable<Int>
                return CustomObservable
                    .randomNumber()
                    .debug("랜덤넘버 옵저버블")
            }
            .debug("서치바 옵저버블")
        /**
         2025-08-25 11:50:03.953: 서치바 옵저버블 -> subscribed  #서치기능이 되려면 dispose되지 않음(처음 한번만 subscribe)
         
         #엔터쳐보면 나오는 동작
         2025-08-25 11:50:13.070: 랜덤넘버 옵저버블 -> subscribed  #커스텀옵저버블 구독 시작
         2025-08-25 11:50:13.073: 랜덤넘버 옵저버블 -> Event next(9)  #랜덤넘버에서 이벤트 전달
         2025-08-25 11:50:13.074: 서치바 옵저버블 -> Event next(9)  #그 내용을 서치바에서 받아서 조회해주고 있음
         
         #다시 엔터: 서치바 옵저버블은 또 구독되지 않음
         2025-08-25 11:51:55.203: 랜덤넘버 옵저버블 -> subscribed  #매번 새로운 옵저버블 생성중(부모 옵저버블 안에 자식 옵저버블)
         2025-08-25 11:51:55.207: 랜덤넘버 옵저버블 -> Event next(66)  #자식 옵저버블에서 나온 내용을 부모 옵저버블한테 내용 넘겨줌
         2025-08-25 11:51:55.207: 서치바 옵저버블 -> Event next(66)  #그거를 바인드로 뽑아내는 중
         
         리턴키 클릭 -> 랜덤옵저버블 생성 -> 여기서 인트를 얻어오면 -> 이 인트를 부모에 전달해줘서 -> 부모가 어떤 숫자였는지 전달해주는 중
         - 문제는 리턴을 했을 때 매번 새로운 랜덤옵저버블을 만들고 있음 -> 각각의 옵저버블이 부모한테 전달하는 일 실행
         - next로 전달만 하고 있고 리소스가 정리되고 있지 않음
         
         #observer.onCompleted() 리소스 정리 코드 삽입 후,
         2025-08-25 11:56:32.336: 서치바 옵저버블 -> subscribed
         2025-08-25 11:56:38.697: 랜덤넘버 옵저버블 -> subscribed  #내부에서 동작하는 Observable은 계속 정리 중
         2025-08-25 11:56:38.700: 랜덤넘버 옵저버블 -> Event next(88)
         2025-08-25 11:56:38.700: 서치바 옵저버블 -> Event next(88)
         2025-08-25 11:56:38.701: 랜덤넘버 옵저버블 -> Event completed
         2025-08-25 11:56:38.701: 랜덤넘버 옵저버블 -> isDisposed
         
         2025-08-25 11:57:06.125: 랜덤넘버 옵저버블 -> subscribed
         2025-08-25 11:57:06.130: 랜덤넘버 옵저버블 -> Event next(66)
         2025-08-25 11:57:06.130: 서치바 옵저버블 -> Event next(66)
         2025-08-25 11:57:06.131: 랜덤넘버 옵저버블 -> Event completed
         2025-08-25 11:57:06.131: 랜덤넘버 옵저버블 -> isDisposed
         
         #왜?
         #map -> flatMap
         #onCompleted()
         */
            .bind(with: self) { owner, number in
                var data = owner.list.value
                data.insert(number, at: 0)
                owner.list.accept(data)
            }
            .disposed(by: disposeBag)
        // map으로 해도되지만 flatMap이 편함: 한댑스 덜들어갈 수 있음
    }
      */
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
