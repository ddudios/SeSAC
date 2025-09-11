//
//  SimpleTableViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/11/25.
//

import UIKit

class SimpleTableViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
            tableView.dataSource = self
            tableView.delegate = self
            return tableView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
    
}

// 기존 방식으로 TableView 구성: Protocol 2개 호출
extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")!
        
//        cell.textLabel?.text = "systemCell"
//        cell.detailTextLabel?.text = ""
        // 이들을 대체 iOS14+ (기존 데이터 기반 + 최신 레이아웃 사용)
        // content기준으로 UI 조절 가능
        var content = cell.defaultContentConfiguration()
        // 이 메서드를 사용했을 때 UIListContentConfiguration을 만들어줌 (Layout적인 것을 쉽게 만들기 위해서 systemCell과 같은 것
        // 왜 var로 사용? 구조체 기반으로 만들어짐: 하나하나 바꿔주는 것이 아니라 구조체 하나를 구성하고 한번에 바꿔줌
        // UIButton -> 구조체 configuration(15+)
        // Navigation, TabBar -> 구조체
        
        content.text = "테스트"  // textLabel
        content.textProperties.color = .systemGreen
        // text관련 프로퍼티들을 textProperties변수를 통해 지정할 수 있음
        
        content.secondaryText = "우하하"  // detailTextLabel
        content.secondaryTextProperties.color = .red
        
        content.image = UIImage(systemName: "star")
        content.imageProperties.tintColor = .yellow
        content.imageToTextPadding = 30
        
        cell.contentConfiguration = content
        
        return cell
    }
}
