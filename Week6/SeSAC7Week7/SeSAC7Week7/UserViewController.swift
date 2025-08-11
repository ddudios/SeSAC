//
//  UserViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit

class UserViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 60
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        return table
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadButton, resetButton, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
//    var list: [Person] = []
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
        setupActions()
        
        // list가 바뀔때 뭐할래?
        viewModel.list.playAction { _ in
            self.tableView.reloadData()
        }
    }
     
    // 데이터가 바뀌면 테이블뷰가 갱신을 해야한다
    // 테이블뷰는 list만 다루고 있고 -> list가 변하면 reloadData
    // list가 변화가 생겼다는 신호를 받을 수 없을까?
    // Property Observer (didSet 변화 생긴 직후 / willSet 변화 생기기 직전)
    
    
    @objc private func loadButtonTapped() {
//        list = [
//            Person(name: "James", age: Int.random(in: 20...70)),
//            Person(name: "Mary", age: Int.random(in: 20...70)),
//            Person(name: "John", age: Int.random(in: 20...70)),
//            Person(name: "Patricia", age: Int.random(in: 20...70)),
//            Person(name: "Robert", age: Int.random(in: 20...70))
//        ]
        // 몇명 로드되는지, 랜덤 에이지인지, 서버에서 가져오는지 뷰컨은 앙무것도 모름
//        viewModel.load() // 데이터 수정은 했지만 테이블뷰 리로드해줘야함
        // 뷰컨에서부터 값전달을 해줘야 한다
//        tableView.reloadData()
        
        // 우리 눈에만 분리된거지 여전히 load메서드에 연결되어있고 뭐가 들어간지 알 수 있다 (실질적 의미는 없었음)
            // 오류가 생겨야 뷰컨입장에서 정말 모르고 분리된 것이다
            // 직접 호출하는 게 아니라 다른 숫자값을 줌 (값이 바뀌도록)
        viewModel.loadButtonTapped.value = ()  // 0보다 작은 단위를 넘겨줌
    }
    
    @objc private func resetButtonTapped() {
//        list.removeAll()
        // 전체 지워지는건지 알바아님
//        viewModel.reset()
//        tableView.reloadData()
        
        viewModel.resetButtonTapped.value = ()
    }
    
    @objc private func addButtonTapped() {
//        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
//        list.append(jack)
        // 한명추가되는건지 뭔지 다 신경안씀
//        viewModel.add()
//        tableView.reloadData()
        viewModel.addButtonTapped.value = ()
    }
    // 어떤 일을 하는것같긴한데 어떤 걸 하는지 자세히는 모름
}

extension UserViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = "Person List"
        
        [buttonStackView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActions() {
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
}
 
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // list까지는 Field이고 실질적인 값에 접근 .value
        return viewModel.list.value.count  // 그냥 주면 그대로 보여줄게
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        let data = viewModel.cellForRowAtData(indexPath: indexPath.row)
        
//        let person = viewModel.list[indexPath.row]
        
        /*cell.textLabel?.text = "\(person.name), \(person.age)세" */ // 내용 표현해주는 부분은 오류가 안남 (정답은 아니지만 어느 부분을 뷰모델로 넘겨줄까, 문제 안생기는 부분은 ViewController가 꼭 해야하는 일은 아니구나)
        cell.textLabel?.text = data
        
        return cell
    }
}
