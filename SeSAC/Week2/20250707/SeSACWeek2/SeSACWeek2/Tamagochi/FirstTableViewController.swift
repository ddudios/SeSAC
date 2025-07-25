//
//  FirstTableViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/9/25.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    let list = ["Jack", "Finn", "Den"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }

    // 1. 셀 갯수: numberOfRowsInSection
    // ex. 카카오톡 친구 300명
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count  // return은 한 줄인 경우에 한해서 생략이 가능 (implicit return)
        // 300개가 아닌 리스트의 갯수와 맞춰줘야함
    }
    
    // 2. 셀 디자인 및 데이터 처리: cellForRowAt
    // ex. 친구마다 프로필 이미지, 상태메시지, 닉네임 등 다 다름
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        //복붙
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        
//        if indexPath.row == 0 {
//            cell.textLabel?.font = .systemFont(ofSize: 20)
//            cell.textLabel?.text = "Jack"
//            cell.textLabel?.backgroundColor = .yellow
//        } else if indexPath.row == 1 {
//            cell.textLabel?.font = .systemFont(ofSize: 30)
//            cell.textLabel?.text = "Finn"
//            cell.textLabel?.backgroundColor = .lightGray
//        } else if indexPath.row == 2 {
//            cell.textLabel?.font = .systemFont(ofSize: 25)
//            cell.textLabel?.text = "Den"
//            cell.textLabel?.backgroundColor = .green
//        } else {
//            // 항상 else 해줘야함
//            cell.textLabel?.font = .systemFont(ofSize: 15)
//            cell.textLabel?.text = "Mentor"
//            cell.textLabel?.backgroundColor = .gray
//        }
        
//        if indexPath.row == 0 {
//            cell.textLabel?.text = list[0]
//        } else if indexPath.row == 1 {
//            cell.textLabel?.text = list[1]
//        } else if indexPath.row == 2 {
//            cell.textLabel?.text = list[indexPath.row]
//        } else {
//            cell.textLabel?.text = "Mentor"
//        }
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    // 3. 셀 높이: heightForRowAt
    // ex. 스토리보드에서 늘린 건 적용되지 않기 때문에 명확하게 코드로 지정해줘야 한다
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        return 100
    }
    
    
}
