//
//  SettingTableViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/9/25.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let cellIdentifier = "settingCell"
    
    let cellDataSource0 = ["공지사항", "실험실", "버전정보"]
    let cellDataSource1 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let cellDataSource2 = ["고객센터/도움말"]
    
    let sectionHeader = ["전체 설정", "개인 설정", "기타"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .black
        configureNavigationBarUI()
    }
    
    func configureNavigationBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cellDataSource0.count
        } else if section == 1 {
            return cellDataSource1.count
        } else if section == 2 {
            return cellDataSource2.count
        } else {
            print("error: \(#function)")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                cell.textLabel?.text = cellDataSource0[0]
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = cellDataSource0[1]
//            } else {
//                cell.textLabel?.text = "나머지"
//            }
//        }
        
        cell.backgroundColor = .darkGray
        
        if indexPath.section == 0 {
            cell.textLabel?.text = cellDataSource0[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = cellDataSource1[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = cellDataSource2[indexPath.row]
        } else {
            print("error: \(#function)")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
//        if section == 0 {
//            return sectionHeader[0]
//        } else if section == 1 {
//            return sectionHeader[1]
//        } else {
//            return "나머지"
//        }
        
        return sectionHeader[section]
    }
}
