//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import Alamofire

class PhotoViewController: UIViewController {
    
    var firstList: [PhotoInfo] = []  //["고래밥", "칙촉", "카스타드"]
    var secondList: [PhotoInfo] = []  //["아이폰", "아이패드", "애플워치", "맥북"]

    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false  // 테이블뷰 클릭 X
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
    
    //1. 잘 뜨는지 확인
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self  // 인스턴스인데 인스턴스 프로퍼티에 넣으려고 해서 문제생김 -> lazy var
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        return tableView
    }()
     
    let button = {
       let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .brown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
//        callRequest()
//        callRequestAuthor()
        /*
        call(url: "https://picsum.photos/v2/list?page=1") { value in
            self.firstList.append(contentsOf: value)
            self.tableView.reloadData()
            print("1")
        }
        print("1을 큐에 보내고, 2를 큐에 보내기 전")
        call(url: "https://picsum.photos/v2/list?page=3") { value in
            self.secondList.append(contentsOf: value)
            self.authorTableView.reloadData()
            print("2")
        }
         */
        // DispatchGroup: 동시에 끝날 타이밍 탐색
//        dispatchGroupA()  // 3 -> 1, 2
        dispatchGroupB()  // 1, 2 -> 3
    }
    
    func callRequest() {
        let url = URL(string: "https://picsum.photos/v2/list?page=1")
        guard let url else {
            print("error: \(#function)")
            return
        }
        
        AF.request(url)//.responseString { response in dump(response) }
            .responseDecodable(of: [PhotoInfo].self) { response in
                print(response)
                // Server > Struct > Array > TableView
                switch response.result {
                case .success(let value):
                    self.firstList.append(contentsOf: value)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
    
    func callRequestAuthor() {
        let url = URL(string: "https://picsum.photos/v2/list?page=3")
        guard let url else {
            print("error: \(#function)")
            return
        }
        
        AF.request(url)//.responseString { response in dump(response) }
            .responseDecodable(of: [PhotoInfo].self) { response in
                print(response)
                // Server > Struct > Array > TableView
                switch response.result {
                case .success(let value):
                    self.secondList.append(contentsOf: value)
                    self.authorTableView.reloadData()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
    
    func call(url: String, completionHandler: @escaping ([PhotoInfo]) -> Void) {
        AF.request(url).responseDecodable(of: [PhotoInfo].self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func dispatchGroupA() {
        let group = DispatchGroup()
        // page1통신, page3통신을 그룹에서 관리
        
        // 그냥 알바생 한명 더 쓴다 생각하고 내가 담고 싶은 형태로 담아버린다
        // 보통 데이터는 각각의 통신에서 담고 notify에서 UI 작업을 한다
        DispatchQueue.global().async(group: group) {
            self.call(url: "https://picsum.photos/v2/list?page=1") { value in
                self.firstList.append(contentsOf: value)
                print("1")
            }
        }
        
        print("1을 큐에 보내고, 2를 큐에 보내기 전")
        
        DispatchQueue.global().async(group: group) {
            self.call(url: "https://picsum.photos/v2/list?page=3") { value in
                self.secondList.append(contentsOf: value)
                print("2")
            }
        }
        
        // 관리가 끝났다는 생각이 들면 notify를 통해서 main에서 구성이 될 수 있는 형태
            // 그러면 firstList가 먼저 와서 append가 될 지, secondList가 먼저 와서 append가 될 지는 모르겠는데, 둘 다 append가 되고 난 직후에 각각의 TableView를 다른 시점에 갱신하고 있어서 따닥으로 떴는데
            // 같이 묶고 싶다면 TableView 갱신 코드를 notify에 넣어준다
            // UI가 달라질 때를 대비해서, 거의 동시에 main에서 되도록 구현
        group.notify(queue: .main) {
            // UI 갱신 타이밍: notify에서 핸들링
            self.tableView.reloadData()
            self.authorTableView.reloadData()
            print("3")
        }
    }
    
    func dispatchGroupB() {
        // 비동기 메서드의 끝을 알기 위함
        // 끝나는 시점을 알 수 있고, 동시에 결과를 볼 수 있는데
        // 큰 단점: 0이 되기 전까지 notify가 호출되지 않음 -> TableView는 갱신조차 되지 않는다
        let group = DispatchGroup()  // enter: +1 +1 = 2 -> leave: -1 -1 = 0 -> 0이 되는 순간 notify 호출 (ARC카운트와 같은 맥락)
        
        group.enter()
        self.call(url: "https://picsum.photos/v2/list?page=1") { value in
            self.firstList.append(contentsOf: value)
            print("1")
            group.leave()  // 알바생이 응답을 주면 이제 떠나도 좋다 (그룹 관리)
            // 실패했을 시점에서도 leave가 돼야 notify호출을 할 수 있도록 만들어야 한다
        }
        
        group.enter()
        self.call(url: "https://picsum.photos/v2/list?page=3") { value in
            self.secondList.append(contentsOf: value)
            print("2")
            group.leave()
        }
        
        group.notify(queue: .main) {
            // UI 갱신 타이밍: notify에서 핸들링
            self.tableView.reloadData()
            self.authorTableView.reloadData()
            print("3")
        }
    }
}

// Delegate, DataSource를 여러번 호출하는 것은 불가능
extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {  // 개별적으로 프로토콜 3개 안쓴 것과 같은 원리
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == authorTableView {
            return secondList.count  // 4
        } else {
            return firstList.count  // 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 알고 있는 기능을 스스로 응용해보기
        // 테이블뷰가 여러개일 때 구별하라고 tableView매개변수를 줌
        // 메서드를 2개 쓰는 건 안되고 부하직원도 연결되어 있으니까 분기처리로 해결
        if tableView == authorTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier(), for: indexPath) as! AuthorTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            let row = secondList[indexPath.row]
            cell.authorLabel.text = row.author
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            let row = firstList[indexPath.row]
            cell.titleLabel.text = row.author
            
            // 둘 다 체크되지 않도록 막기
                // 뷰 자체 클릭 안되게 / 셀 클릭 안되게
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, tableView)
        // 버튼으로 들어갔을 때는 present - dismiss
            // 셀로 들어갔을 때는 push - pop
            // 조건 분기처리 (같은 버튼에 다른 기능 구현)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
     
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
         
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        
        // 버튼 클릭 시 DetailViewController Present
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        let vc = DetailViewController()
        
//        vc.content = "안녕하세요"
        // 실행하지 않고 함수만 그 자체를 넣어줌 (기능 전달)
        // 함수의 기능만 넣어줌, 아직 실행은 하지 않은 상태
//        vc.content = {
//            self.button.setTitle("안녕하세요", for: .normal)
//        }
        // 매개변수로 텍스트필드 글자 전달 (매개변수: reponse)
        vc.content = { response in
            self.button.setTitle(response, for: .normal)
        }
        
        
//        navigationController?.pushViewController(vc, animated: true)
        
        // 첫화면의 Nav -> PhotoView -> Detail
        // Nav -> Photo | present Nav -> Detail
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}
