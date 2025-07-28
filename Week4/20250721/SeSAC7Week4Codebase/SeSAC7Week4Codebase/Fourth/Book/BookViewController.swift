//
//  BookViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/25/25.
//

import UIKit
import Alamofire
import SnapKit

class Hello {
    let name: String = "dfa"
    let age: Int = 4
    
    // 선언, 초기화가 모두 되어있다면 굳이 init구문 필요없다
    // 옵셔널 -> nil이 들어올 수 있는 상황이여서 init구문 필요없다
}

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
//    var list: KaKaoBookInfo?  // 값을 다 채워주기 귀찮으니까 보통 옵셔널로 놓기도 한다, 매번 데이터를 넣어주기 귀찮으니까
    var list: [BookDetail] = []  // 가장 높은 댑쓰의 것을 주는 것이 아닌 내가 받아올 부분에 대해서만 담아오도록, 빈배열을 줘서 애초에 옵셔널을 해결하지 않도록 만듦
    var page = 1
    var is_end = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()  // addSubview를 한 다음에 레이아웃이 잡혀야하기 때문에 순서 중요
        configureLayout()
        configureView()
        print(#function, list)
    }
    
    func callRequestKakao(query: String) {
        print("첫번째")
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": "KakaoAK 5eefae3d8336814cb36cbd87d26acb89"
        ]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of: KaKaoBookInfo.self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                print("success", value)
//                dump(value)
                
                self.is_end = value.meta.is_end
                
//                self.list = value.documents
//                value.documents  // 여기서도 내가 쓸 내용만 필터링 가능
                
                // 위의 셀 내용이 없어짐
                // 배열의 갯수는 이전 데이터를 보여주기 위해서 계속 추가해줘야한다
                self.list.append(contentsOf: value.documents)
                self.tableView.reloadData()
                
                // 리로드 데이터 뒤에 작성해야 데이터가 있는 상태에서 최상단으로 보내줄 수 있다
                if self.page == 1 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
    }

    
//    func callRequest(query: String) {
//        print(#function, "첫번째")
//        let url = "https://openapi.naver.com/v1/search/book.json?query=\(query)&display=30"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": "Svpt2S_nL8EkKAO2GZYM",
//            "X-Naver-Client-Secret": "hnHlvaRQiO"
//        ]
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of: BookInfo.self) { response in
//            print(#function, "두번째")
//            switch response.result {
//            case .success(let value):
//                print("success", value)
//                dump(value)
//                self.list = value  // 테이블뷰가 그려지는 것보다 데이터가 오는 속도가 항상 느리기때문에 리로드 과정이 항상 필요하다
//                self.tableView.reloadData()
//            case .failure(let error):
//                print("fail", error)
//            }
//        }
//        print(#function, "세번째")
//    }
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
        searchBar.text = ""
        list.removeAll()
        page = 1
        callRequestKakao(query: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 사용자 입장에서 어떤게 편할까 생각하다보면 이런 처리들도 계속 늘어날 것이다
        searchBar.text = ""
        list.removeAll()  //list = nil  // 다시 없는 상태로 만들어준다  // BookInfo(items: [])
        tableView.reloadData()
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // list가 nil일 때는 테이블을 어떻게 그려주지?
        
//        if list != nil {
//            return list!.documents.count
//        } else {
//            return 0
//        }
//        guard let list = list else {
//            return 0
//        }
//        return list.documents.count
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as! BookTableViewCell
        print(#function, indexPath)
//        guard let list = list else {
//            return UITableViewCell()  // 아무것도 디자인되어 있지 않은 셀 리턴 (셀이 0개일 때 실행되는 셀이라서 사용자에게 보이지는 않는다)
//        }
        
//        let row = list.documents[indexPath.row]
        let row = list[indexPath.row]
        cell.titleLabel.text = row.title
        cell.subTitleLabel.text = row.price.formatted()  // iOS15+ 기본적으로 알아서 잘 바꿔준다
        cell.overviewLabel.text = row.contents
        cell.thumbnailImageView.backgroundColor = .blue
        return cell
    }
    
    //Pagenation
    // 스크롤이 다 끝날때 쯤에 다음 페이지를 요청
    // 다음 페이지를 위해서 page 변수를 사용
    // 이전 데이터도 계속 보려고 append로 수정
    // 다른 검색어로 바꾸면 리셋이 아니라 계속 append 있음: 다른 검색을 했을 때, 이전 검색 기록이 append가 되다보니까 계속 남아있는 형태 > 배열 비워주고, 페이지를 1번부터 다시 시작
    // 새롭게 검색하는 경우에는 스크롤을 위로 올려주는 게 필요
    // 마지막 페이지에 대한 처리
        // 10페이지가 마지막이면, 11, 12, 13요청하면 빈페이지면 괜찮은데, 카톡은 라스트를 주다보니까 무한대로 나오는 경우 (마지막이 되면, 같은 책이 계속 나옴: 끝이 있는데 끝없이 같은 책이 반복되어 나옴)
        // 카톡은 is_end값을 : false를 뱉다가 마지막 페이지에서 true를 줌, true일 때 더이상 네트워크를 하지 않게 (네이버는 이즈앤드값을 안주니까 토탈카운트로)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        
//        if indexPath.row == 17 {  // 20 받아올 때 17에서 통신, 40페이지 받아오고 싶을 때 37에서 통신 지금은 이부분이 안됨
//            callRequestKakao(query: searchBar.text!)
//        }
        // 20 > 40 > 60 > 80 원하는 다음 페이지 row
        // 17 > 37 > 57 > 77 일때 다음 페이지 요청
        // 1  >  2 >  3 > 4 페이지
        // true일 때는 네트워크 통신 X
        if indexPath.row == (list.count - 3) && is_end == false {
            page += 1
            is_end = false
            callRequestKakao(query: searchBar.text!)  // 예외처리 -> 변수로 담아서 / 화면을 넘기거나
        }
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
