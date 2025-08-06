//
//  SettingViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import UIKit
import SnapKit

// CaseIterable프로토콜 채택시
    // allCases: case선언 순서대로 내용을 구성할 수 있음
    // -> 테이블뷰 코드를 변경하지 않고 열거형의 내용만 변경하면 순서를 변경할 수 있다
enum Setting: String, CaseIterable {
    case setting = "설정"
//    case setting  // enum은 고유한 내용을 다룰 때 유용함: 같은 스펠링, 같은 케이스 사용 못함
    case version = "버전정보"
    case push = "푸시설정"
    case personal = "개인정보"
    // detail과 배열, 테이블뷰의 조건문 건들지 않고 순서바꾸기 가능
    // 섹션 추가시에도 섹션순서 열거형만 신경쓰면 되고, detail은 순서상관없으니까 내용만 추가하면된다 (VC코드르 볼 필요없이 열거형만 신경써면 된다)
    // 수정시 연쇄적으로 수정하는 코드가 적을 수록 유지보수에 좋음
    
    // 각각의 케이스에 대해서 배열 리턴
    var detail: [String] {
        switch self {
        case .setting:
            return ["알림", "채팅", "친구"]
        case .version:
            return ["개인정보처리방침", "오픈소스라이센스", "기타"]
        case .personal:
            return ["프로필 수정", "회원탈퇴"]
        case .push:
            return ["푸시", "알림"]
        }
    }
}

class SettingViewController: UIViewController {
    
//    let list = ["설정", "버전정보", "개인정보"]  // 순서를 바꾸면 섹션 헤더 바꾸고, 섹션 안의 데이터, 셀이 꼬이지 않게 바꿔줘야 한다
//    let list = Setting.allCases
    
//    let detail = ["알림", "채팅", "친구"]
//    let info = ["프로필 수정", "회원탈퇴"]
//    let version = ["개인정보처리방침", "오픈소스라이센스", "기타"]
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 세팅 안의 케이스에서 디테일을 가져오면 선택한 내용을 가져올 수 있음 (각각의 문자열 꺼내오기)
//        print(Setting.setting.rawValue)  // 개인정보
//        print(Setting.setting.detail)  // ["개인정보처리방침", "오픈소스라이센스", "기타"]
//        print(Setting.setting.detail[1])  // 오픈소스라이센스
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return list.count
        return Setting.allCases.count
    }
    
    //각각의 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*
        if section == 0 {
            return list[0]
        } else if section == 1 {
            return list[section]
        } else {
            list[section]
        }*/

        // [String]에서 [Setting]열거형타입으로 바뀌었으니까 -> [String]
//        return list[section].rawValue
        return Setting.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if section == 0 {
                // 세팅 열거형의 세팅 케이스의 디테일의 갯수만큼 가져오겠다
//            return Setting.setting.detail.count
//            return Setting.allCases[0].detail.count
            return Setting.allCases[section].detail.count
            } else if section == 1 {
                // 세팅 열거형의 버전의 디테일의 카운트
//                return Setting.version.detail.count
//                return Setting.allCases[1].detail.count
                return Setting.allCases[section].detail.count
            } else {
//                return Setting.personal.detail.count
//                return Setting.allCases[2].detail.count
                return Setting.allCases[section].detail.count
            }*/
        
        return Setting.allCases[section].detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        /*
        if indexPath.section == 0 {
//            let row = detail[indexPath.row]
//            let row = Setting.setting.detail[indexPath.row]
            let row = Setting.allCases[0].detail[indexPath.row]
            cell.settingLabel.text = row
        } else if indexPath.section == 1 {
//            let row = version[indexPath.row]
//            let row = Setting.version.detail[indexPath.row]
            let row = Setting.allCases[1].detail[indexPath.row]
            cell.settingLabel.text = row
        } else {
//            let row = info[indexPath.row]
//            let row = Setting.personal.detail[indexPath.row]
            let row = Setting.allCases[2].detail[indexPath.row]
            cell.settingLabel.text = row
        }*/
        let row = Setting.allCases[indexPath.section].detail[indexPath.row]
        cell.settingLabel.text = row
        
//        let row = list[indexPath.row]
//        cell.settingLabel.text = row
        return cell
        
    }
}


extension SettingViewController {
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureView() {
        navigationItem.title = "네비게이션 타이틀"
        view.backgroundColor = .white
    }
}
