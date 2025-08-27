//
//  FriendViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

/*
 - 아웃렛 필요 (개별적인 네이밍)
 - 부하직원 호출: UITableViewDelegate, UITableViewDataSource
 - 메서드 호출: numberOfRowsInSection, cellForRowAt, ...
 - 테이블뷰랑 부하직원 연결
 */

// 부하직원을 달고 나올 수 있다
class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mySearchBar: UISearchBar!
    @IBOutlet var myTableView: UITableView!
    
    private var list = FriendsInfo().list  // 필터링된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self, #function)
        configureBackgroundColor()
        configureTableView()
    }
    
    @IBAction func totalButtonClicked(_ sender: UIButton) {
    }
    
    // 20명 > 10명 (항상 데이터를 기준으로)
    @IBAction func profileButtonClicked(_ sender: UIButton) {
        print(#function)
        // 전체 데이터 - 항상 전체 데이터에서 시작
        let all = FriendsInfo().list
        
        // 해당 데이터 담아줄 공간
        var filter: [Friends] = []
        
        // 장기적으로는 이게 더 적게 걸림
        for item in all {
            if item.profile_image != nil {
                // 전체 중 프로필 이미지가 있는
                filter.append(item)
                print("조건문", item)
            }
        }
        dump(filter)
        // 필터링 데이터 보여주는 곳의 값 변경
        list = filter
        myTableView.reloadData()
    }
    
    @IBAction private func filterButtonClicked(_ sender: UIButton) {
        // like == true
        // 전체 데이터는 건드리지 않는다
        // 전체 데이터는 수정하지 않으니까 전체 데이터 가져옴 -> 데이터 덮어쓰기
        let all = FriendsInfo().list
        var filter: [Friends] = []
        
        for item in all {
            if item.like {
                filter.append(item)
            }
        }
        // all이 아닌 list를 돈다면?
            // 앱 실행시: list 20개 전체
            // 프로필 있는 버튼 클릭시: list 15개 필터링된 데이터
            // 좋아요 버튼 클릭시: list 15개 유지된 상태에서 필터링된 데이터
            // 전체 데이터와 필터링 데이터를 명확하게 구분해서 사용해야 한다
            // 따지고 보면 list는 필터링된 데이터 (처음엔 전체 데이터일지 몰라도)
        
        // 모든 테이블의 곳곳에서 계속 list를 활용하기 때문에 모든 곳에서 list를 바라보고 있어야 한다
        list = filter
        myTableView.reloadData()
    }
    
    
    private func configureTableView() {
//        print(#function)
        myTableView.delegate = self  // ⭐️테이블뷰의 부하직원이 이 컨트롤러에 있음을 인식시킴
        myTableView.dataSource = self
        
        myTableView.backgroundColor = .clear
        
        // 아웃렛연결했으니까 tableView.이 아닌 myTableView.
//        myTableView.rowHeight = 200
        let xib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
        myTableView.register(xib, forCellReuseIdentifier: "NoProfileTableViewCell")
        let xib2 = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        myTableView.register(xib2, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    @objc
    private func likeButtonClicked(_ sender: UIButton) {
        print(#function, sender.tag)
        // 0번 셀 버튼 클릭 > list[0].like
        // 1번 셀 버튼 클릭 > list[1].like
        // indexPath.row번 셀 버튼 클릭 > list[indexPath.row].like
        
        // 데이터 바뀌기 전, 후 데이터 확인
        dump(list)
        print("Before")
        dump(list[sender.tag])
//        if list[sender.tag].like == true {
//            list[sender.tag].like = false
//        } else {
//            list[sender.tag].like = true
//        }
        
//        list[sender.tag].like = !list[sender.tag].like
        
        list[sender.tag].like.toggle()
        dump("After")
        dump(list[sender.tag])
        
        // like -> 그 셀 하나만 변경되니까 전체 리로드 필요없음
        // 내가 선택한 셀에 대해서만 갱신
        myTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    // override 없어짐
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(#function)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
        if list[indexPath.row].profile_image == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as! NoProfileTableViewCell
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell.configureData(list[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.configureData(row: list[indexPath.row])
            return cell
        }
        
//        let row = list[indexPath.row]
        
        /*
        // 메서드로 분리
        // 1. 달라지지 않을 정적인 디자인
        // 2. 데이터 기반: 각각의 셀마다 달라질 수 있는 내용들을 각각의 메서드로 분리
        cell.backgroundColor = .clear
        cell.nameLabel.text = row.name
        
        cell.likeButton.layer.cornerRadius = 22
        cell.likeButton.clipsToBounds = true
        
        /*
        // message가 없다면 label영역 자체를 hidden
         // 스택뷰에 담겨있어야 hidden을 하면 영역도 같이 사라짐
//        cell.messageLabel.text = row.message
        if row.message != nil {
            cell.messageLabel.text = row.message
            cell.messageLabel.isHidden = false
        } else {
            cell.messageLabel.text = ""  // = nil이여도 상관없으니까, = row.message로 써도 됨
            cell.messageLabel.isHidden = true
        }*/
        // 같은 내용은 밖으로 빼고 분기처리 부분만 넣어도 됨
        cell.messageLabel.text = row.message
        if row.message != nil {
            cell.messageLabel.isHidden = false
        } else {
            cell.messageLabel.isHidden = true
        }*/
        
        // (한계) section이 하나일 때만 가능한 코드
        // cell.likeButton.tag에 indexPath.row가 들어있고
//        cell.likeButton.tag = indexPath.row
//        if indexPath.row == 0 {
//            cell.likeButton.tag = 0
//        } else if indexPath.row == 1 {
//            cell.likeButton.tag = 1
//        }
        /*
        // 지금 잘 된다고 해서 모든 경우에 잘 돌아가는 것은 아니다
        // 섹션이 여러개일 때 해결 방법 중 한가지
        if indexPath.section == 0 {
            cell.likeButton.tag = indexPath.row
        } else indexPath.section == 1 {
            cell.likeButton.tag = indexPath.row + 100000  // 절대 인덱스가 겹치지 않게 설정
        }*/
        
//        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        // likeButton과 likeButtonClicked를 연결하는 건데 매개변수로 cell.likeButton를 넣어줌
            // cell.likeButton.addTarget(self, action: #selector(likeButtonClicked(cell.likeButton)), for: .touchUpInside)
        // 함수를 실행해서는 안되기 때문에 매개변수를 지워주는데
        // 매개변수를 쓰지 않지만 매개변수에 버튼에 대한 모든 것이 들어간다, 그 기능까지 다 해주는게 addTarget (11:21)
        
        /*
        if row.phone != nil {
            cell.phoneLabel.text = "\(row.phone!)"
        } else {
            cell.phoneLabel.text = "연락처 없음"
        }
        
        // 항상 데이터를 기준으로
        if row.like {
            let image = UIImage(systemName: "heart.fill")
            cell.likeButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "heart")
            cell.likeButton.setImage(image, for: .normal)
        }*/
        
//        cell.configureData(list[indexPath.row])
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row.isMultiple(of: 2) {
        if list[indexPath.row].profile_image == nil {
            return 150
        } else {
            return 100
        }
    }
    
    // 셀 선택됐을 때 화면 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
//        vc.name = list[indexPath.row].name
//        vc.message = list[indexPath.row].message
//        vc.phone = list[indexPath.row].phone
        
//        let row = list[indexPath.row]
//        vc.profile = row
        vc.profile = list[indexPath.row]
        
        present(vc, animated: true)
    }
}
