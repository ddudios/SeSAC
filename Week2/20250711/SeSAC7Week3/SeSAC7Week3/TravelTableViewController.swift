//
//  TravelTableViewCell.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/14/25.
//

import UIKit

struct Travel {
    let name: String
    let overview: String
    let date: String
    let like: Bool
}

class TravelTableViewController: UITableViewController {

    let nickname = "고래밥"
    let format = DateFormatter()
    
    let travel = [
        Travel(name: "서울", overview: "선유도공원 좋아요", date: "250401", like: false),
        Travel(name: "대전", overview: "좋아요", date: "250101", like: true),
        Travel(name: "대구", overview: "123", date: "251201", like: true),
        Travel(name: "부산", overview: "gg", date: "250813", like: false),
        Travel(name: "광주", overview: "aaa", date: "250505", like: false)
    ]
    
    // 나의 실수 방지하기 위해 프로퍼티로 만듦
    // 클래스 안이라면 프로퍼티, 앞에 static 키워드 없으니까 인스턴스 프로퍼티
//    let identifier = "TravelTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .darkGray
        setBackground()
        
        // 별도의 XIB Cell로 구성하는 순간, 필요한 코드
        // register: 등록 - XIB파일 + 재사용Cell
        // nibName: 파일명, bundel: nil(우리가 만든 파일 안에서 가져오면 nil, 외부 Xib파일에 들어있는 위치)
        let xib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        // 클래스
        let format = DateFormatter()
        format.dateFormat = ""
        let alert = UIAlertController()
//        alert.addAction(<#T##UIAlertAction#>)
        
        // 구조체
        let com = DateComponents()
//        com.year = 234  //error: 큰곳에서 자물쇠 ->(해결) var com
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
        // 스토리보드에 워낙 많은 내용이 들어있어서 스토리보드를 부르느라 길게 씀
        
        print(#function)
        /*
//        let nickname = "고래밥"
//        cell.travelLabel.text = "\(nickname)dajdklsdfjalskdfjaskl;dfjasld;kfajs;dflkasdjfkal;sdjfalsdjfk;alksdjfkalsjdfalskdjflasjdf;alskdjfalskdjfalskdjfljasdfjk\ndjfalsdjkf;asjdfklasdkjflaksdjf;laksjdf;alksjdlfkjsdlkjasjlfasjkdlfaj;sdjfk;asdfjalksdfja;sldjfal;skdfjalskdjfalksfjkjflsa;"
        // 셀로 이동
//        cell.travelLabel.text = travel[indexPath.row].overview
//        cell.travelLabel.numberOfLines = 0
//        cell.travelLabel.backgroundColor = .clear
        cell.configureTravelLabel(row: travel[indexPath.row])
        
//        let format = DateFormatter()
//        format.dateFormat = "yy년 MM월 dd일 hh시"
//        let value = format.string(from: Date())
        
//        cell.dateLabel.text = travel[indexPath.row].name  // 둘 다 String?이면 "\()" 굳이 쓰지 않기
//        cell.dateLabel.backgroundColor = .clear
        // 셀로 이동
        cell.configureDateLabel(row: travel[indexPath.row])
        
        // 셀로 이동
//        if travel[indexPath.row].like {
//            cell.backgroundColor = .yellow
//        } else {
//            cell.backgroundColor = .clear
//        }
        cell.configureBackground(row: travel[indexPath.row])
        */
        cell.configureCell(row: travel[indexPath.row])
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row < 3 {
//            return UITableView.automaticDimension
//        } else {
//            return 100
//        }
//    }
}
