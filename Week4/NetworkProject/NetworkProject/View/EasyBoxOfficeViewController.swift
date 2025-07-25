//
//  EasyBoxOfficeViewController.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/25/25.
//

import UIKit
import Alamofire

final class EasyBoxOfficeViewController: UIViewController {
    private let searchTextField = {
        let textField = SearchTextField(borderStyle: .roundedRect, keyboardType: .numbersAndPunctuation)
        textField.text = "20250723"
        return textField
    }()
    
    private let firstRankLabel = EasyBoxOfficeLabel()
    private let secondRankLabel = EasyBoxOfficeLabel()
    private let thirdRankLabel = EasyBoxOfficeLabel()
    
    private let firstMovieNameLable = EasyBoxOfficeLabel()
    private let secondMovieNameLable = EasyBoxOfficeLabel()
    private let thirdMovieNameLable = EasyBoxOfficeLabel()
    
    private let firstOpenDateLabel = EasyBoxOfficeLabel()
    private let secondOpenDateLabel = EasyBoxOfficeLabel()
    private let thirdOpenDateLabel = EasyBoxOfficeLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        networking()
    }
    
    private func networking() {
        let key = "5b169fc7c3f7c25eda2c695ea9a970d6"
        guard let date = searchTextField.text else {
            print("error: \(#function)")
            return
        }
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
        AF.request(url, method: .get).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                self.firstRankLabel.text = value.boxOfficeResult.dailyBoxOfficeList.first?.rank
                self.secondRankLabel.text = value.boxOfficeResult.dailyBoxOfficeList[1].rank
                self.thirdRankLabel.text = value.boxOfficeResult.dailyBoxOfficeList[2].rank
                
                self.firstMovieNameLable.text = value.boxOfficeResult.dailyBoxOfficeList.first?.movieNm
                self.secondMovieNameLable.text = value.boxOfficeResult.dailyBoxOfficeList[1].movieNm
                self.thirdMovieNameLable.text = value.boxOfficeResult.dailyBoxOfficeList[2].movieNm
                
                self.firstOpenDateLabel.text = value.boxOfficeResult.dailyBoxOfficeList.first?.openDt
                self.secondOpenDateLabel.text = value.boxOfficeResult.dailyBoxOfficeList[1].openDt
                self.thirdOpenDateLabel.text = value.boxOfficeResult.dailyBoxOfficeList[2].openDt
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
}

extension EasyBoxOfficeViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchTextField)
        view.addSubview(firstRankLabel)
        view.addSubview(secondRankLabel)
        view.addSubview(thirdRankLabel)
        view.addSubview(firstMovieNameLable)
        view.addSubview(secondMovieNameLable)
        view.addSubview(thirdMovieNameLable)
        view.addSubview(firstOpenDateLabel)
        view.addSubview(secondOpenDateLabel)
        view.addSubview(thirdOpenDateLabel)
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        firstRankLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.leading)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        secondRankLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.leading)
            make.top.equalTo(firstRankLabel.snp.bottom).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        thirdRankLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.leading)
            make.top.equalTo(secondRankLabel.snp.bottom).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        firstMovieNameLable.snp.makeConstraints { make in
            make.leading.equalTo(firstRankLabel.snp.trailing).offset(8)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.trailing.equalTo(firstOpenDateLabel.snp.leading).offset(-8)
        }
        
        secondMovieNameLable.snp.makeConstraints { make in
            make.leading.equalTo(secondRankLabel.snp.trailing).offset(8)
            make.top.equalTo(firstRankLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.trailing.equalTo(secondOpenDateLabel.snp.leading).offset(-8)
        }
        
        thirdMovieNameLable.snp.makeConstraints { make in
            make.leading.equalTo(thirdRankLabel.snp.trailing).offset(8)
            make.top.equalTo(secondRankLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.trailing.equalTo(thirdOpenDateLabel.snp.leading).offset(-8)
        }
        
        firstOpenDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(searchTextField.snp.trailing).offset(8)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        secondOpenDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(searchTextField.snp.trailing).offset(8)
            make.top.equalTo(firstRankLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        thirdOpenDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(searchTextField.snp.trailing).offset(8)
            make.top.equalTo(secondRankLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        searchTextField.delegate = self
    }
}

extension EasyBoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        networking()
        searchTextField.text = "검색결과: \(textField.text!)"
        view.endEditing(true)
        return true
    }
}
