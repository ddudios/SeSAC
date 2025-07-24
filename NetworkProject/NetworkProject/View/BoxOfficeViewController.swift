//
//  BoxOfficeViewController.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import SnapKit

class BoxOfficeViewController: UIViewController {
    //MARK: 왜 CGRect설정하라고하지 (ImageView는 아마 설정하는 법이 다를 것이다)
//    private let boxOfficeBackgroundImageView = BoxOfficeBackgroundImageView()
    private let searchBackgroundView = SearchBackgroundView()
    //MARK: ?? 왜안되는거지
//    var title = "Box Office"
    private let searchTextField = SearchTextField()
    private let textFieldUnderLineView = DividerLine()
    private let searchButton = {
        let button =  SearchButton()
        //MARK: 수정해보기
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    private let tableView = UITableView()
    
    private var movies = MovieInfo.movies

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    //MARK: - Selectors
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func searchButtonTapped() {
        shuffleData()
    }
    
    private func shuffleData() {
        movies = MovieInfo.movies.shuffled()
        tableView.reloadData()
    }
}

//MARK: - ViewDesignProtocol
extension BoxOfficeViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(searchTextField)
        searchBackgroundView.addSubview(textFieldUnderLineView)
        searchBackgroundView.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        searchBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(searchBackgroundView.snp.leading)
            make.trailing.equalTo(searchButton.snp.leading).offset(4)
        }
        
        textFieldUnderLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(searchBackgroundView.snp.bottom)
            make.width.equalTo(searchTextField.snp.width)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(39)
            make.centerY.equalTo(searchBackgroundView.snp.centerY)
            make.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(searchBackgroundView.snp.horizontalEdges)
            make.top.equalTo(searchBackgroundView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureTableView()
        
        searchTextField.delegate = self
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "BOX OFFICE"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationItem.rightBarButtonItem = backBarButtonItem
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 50
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        tableView.separatorStyle = .none  // 셀 구분선 스타일
    }
}

//MARK: 왜안되는거지
extension BoxOfficeViewController: NavigationDesignProtocol {
    var navigationTitle: String {
        "Box Office"
    }
}

//MARK: 수정
extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.movieNameLabel.text = movies[indexPath.row].title
        cell.dateLabel.text = CustomDateFormat.getDateString(dateData: movies[indexPath.row].releaseDate)
        
        return cell
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shuffleData()
        view.endEditing(true)
        return true
    }
}
