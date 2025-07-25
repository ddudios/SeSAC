//
//  BookViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/25/25.
//

import UIKit
import Alamofire
import SnapKit

class BookViewController: UIViewController {
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.id)
        return tableView
    }()
    
    let searchBar = UISearchBar()
    
//    var list: [String] = ["국어", "수학", "사회", "과학", "영어"]
    var list: BookInfo = BookInfo(items: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()  // addSubview를 한 다음에 레이아웃이 잡혀야하기 때문에 순서 중요
        configureLayout()
        configureView()
    }
    
    func callRequest(query: String) {
        print(#function, "첫번째")
        let url = "https://openapi.naver.com/v1/search/book.json?query=\(query)&display=30"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "Svpt2S_nL8EkKAO2GZYM",
            "X-Naver-Client-Secret": "hnHlvaRQiO"
        ]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of: BookInfo.self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                print("success", value)
                dump(value)
                self.list = value  // 테이블뷰가 그려지는 것보다 데이터가 오는 속도가 항상 느리기때문에 리로드 과정이 항상 필요하다
                self.tableView.reloadData()
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
    }
}

// addTarget아니면 거의 다 Delegate 연결
extension BookViewController: UISearchBarDelegate {
    // 글자 달라질때마다 호출
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function, searchBar.text)
    }
    
    // 검색 버튼 클릭시 호출
    // 콜 수 제한을 둔다 (해킹하려고 계속 호출할 수도 있기 때문) - 네이버는 25,000/일
        // 검색 키워드가 달라질 때마다 호출하면 너무 많은 콜 수가 많기 때문에 보통 네트워크 통신에는 실시간 검색보다는 키보드 검색 시 통신이 있는 경우가 많음
    // 책은 실시간으로 변경되는 내용이 많지 않을 것이다 - 도서 서비스 특성상, 같은 검색어로 또 요청을 할 필요가 있을까?
        // 네이버 주식은 실시간으로 변경돼야하긴 함
    // 같은 검색어로 요청을 무조건 막는게 맞을까? (일주일동안 검색창을 열어놨을 때 새로운 책이 들어올 수도 있다)
        // 이런 생각들로 인해 고려하기 위해 Todo list가 얼마나 많은지.. -> 검색기능말고도 생각할 것이 너무 많음, 이런 것들을 찾아가는 것이 앞으로 개발하면서 신경써야할 요소이다
    // 간단하게는 글자수 제한
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text, text.count > 0 else {
            print("빈값을 입력했어요")  // 토스트메세지, 얼럿 등에 띄워줄 수 있음
            return
        }
        callRequest(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // 사용자 입장에서 어떤게 편할까 생각하다보면 이런 처리들도 계속 늘어날 것이다
        searchBar.text = ""
        list = BookInfo(items: [])
        tableView.reloadData()
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as! BookTableViewCell
        let row = list.items[indexPath.row]
        cell.titleLabel.text = row.title
        cell.subTitleLabel.text = "\(row.author) 작가 (\(row.pubdate)출간)"
        cell.overviewLabel.text = row.description
        cell.thumbnailImageView.backgroundColor = .blue
        return cell
    }
}

extension BookViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag  // 키보드 내려주는 시점
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
}

/*
 무한스크롤/페이지네이션
 서비스적 고려사항
 HTTP 특성, RestAPI 특성 (강의자료 안보고 코드짜고 로직 이해가 먼저)
 상태코드 예외처리: 200번대가 아닌 다른 처리
    - 네트워크 단절
    - 인증 콜 수 다 씀
    - 올바르지 않은 쿼리 사용 등
 네트워크 통신 코드는 순서가 왜 다를까? 비동기
    - 다른 알바생에 대한 이야기...
 */
