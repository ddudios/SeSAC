//
//  LotteryViewController.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import Alamofire

class LotteryViewController: UIViewController {

    private let navigationSeparatorLine = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var roundTextField = {
        let textField = PickerTextField()
        textField.text = "1181회차"
        textField.inputView = self.lotteryPickerView
        return textField
    }()
    private let categoryLabel = {
       let label = CategoryLabel()
        label.text = "당첨번호 안내"
        return label
    }()
    private let separatorView = DividerLine()
    private let dateLabel = {
        let label = DateLabel()
        label.text = "2020-05-30 추첨"
        return label
    }()
//    private let titleLabel = {
//        let label = TitleLabel()
//        label.text = "913회 당첨결과"
//
    // MARK: 왜 순환참조 일어나는지 생각해보기
//        let attributedString = NSMutableAttributedString()
//        if let title = titleLabel.text {
//            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: (title as NSString).range(of: "당첨결과"))
//        }
//        return label
//    }()
    private let titleLabel = TitleLabel()
    private let firstResultLabel = {
        let label = ResultLabel()
        label.text = "6"
        label.backgroundColor = .lotteryYellow
        return label
    }()
    private let secondResultLabel = {
        let label = ResultLabel()
        label.text = "14"
        label.backgroundColor = .lotteryBlue
        return label
    }()
    private let thirdResultLabel = {
        let label = ResultLabel()
        label.text = "16"
        label.backgroundColor = .lotteryBlue
        return label
    }()
    private let fourthResultLabel = {
        let label = ResultLabel()
        label.text = "21"
        label.backgroundColor = .lotteryRed
        return label
    }()
    private let fifthResultLabel = {
        let label = ResultLabel()
        label.text = "27"
        label.backgroundColor = .lotteryRed
        return label
    }()
    private let sixthResultLabel = {
        let label = ResultLabel()
        label.text = "37"
        label.backgroundColor = .lotteryGray
        return label
    }()
    private let seventhResultLabel = {
        let label = ResultLabel()
        label.text = "+"
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    private let eighthdResultLabel = {
        let label = ResultLabel()
        label.text = "40"
        label.backgroundColor = .lotteryGray
        return label
    }()
    private let resultStackView = LotteryResultStackView()
    private let bonusLabel = BonusLabel()
    
    private let resultLabelSize = 39
    
    private let lotteryPickerView = UIPickerView()
    private let numberList: [Int] = Array(1...1181).reversed()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        networkService(1181)
    }
    
    //MARK: - Selectors
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    func networkService(_ row: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(row)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Lottery.self) { response in
            switch response.result {
            case .success(let value):
                self.firstResultLabel.text = "\(value.drwtNo1)"
                self.secondResultLabel.text = "\(value.drwtNo2)"
                self.thirdResultLabel.text = "\(value.drwtNo3)"
                self.fourthResultLabel.text = "\(value.drwtNo4)"
                self.fifthResultLabel.text = "\(value.drwtNo5)"
                self.sixthResultLabel.text = "\(value.drwtNo6)"
                self.eighthdResultLabel.text = "\(value.bnusNo)"
                self.dateLabel.text = "\(value.drwNoDate)"
                self.titleLabel.text = "\(row)회 당첨결과"
                
                //MARK: 왜 클래스 안에 넣으면 색깔변경이 안되지..
                if let title = self.titleLabel.text {
                    let attributedString = NSMutableAttributedString(string: title)
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: (title as NSString).range(of: "당첨결과"))
                    self.titleLabel.attributedText = attributedString
                } else {
                    print("error: \(#function)")
                    return
                }
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
}

//MARK: - ViewDesignProtocol
extension LotteryViewController: ViewDesignProtocol {
    func configureHierarchy() {
//        view.addSubview(navigationSeparatorLine)
        view.addSubview(roundTextField)
        view.addSubview(categoryLabel)
        view.addSubview(separatorView)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(resultStackView)
        //MARK: lazy 활용해서 스택뷰 묶어주기
        resultStackView.addArrangedSubview(firstResultLabel)
        resultStackView.addArrangedSubview(secondResultLabel)
        resultStackView.addArrangedSubview(thirdResultLabel)
        resultStackView.addArrangedSubview(fourthResultLabel)
        resultStackView.addArrangedSubview(fifthResultLabel)
        resultStackView.addArrangedSubview(sixthResultLabel)
        resultStackView.addArrangedSubview(seventhResultLabel)
        resultStackView.addArrangedSubview(eighthdResultLabel)
        view.addSubview(bonusLabel)
    }
    
    func configureLayout() {
//        navigationSeparatorLine.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.centerY.equalTo(view.safeAreaLayoutGuide)
//        }
        
        roundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(44)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(roundTextField.snp.leading)
            make.top.equalTo(roundTextField.snp.bottom).offset(30)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(separatorView.snp.trailing)
            make.centerY.equalTo(categoryLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        firstResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        secondResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        thirdResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        fourthResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        fifthResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        sixthResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        seventhResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        eighthdResultLabel.snp.makeConstraints { make in
            make.size.equalTo(resultLabelSize)
        }
        
        resultStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(separatorView.snp.horizontalEdges)
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(eighthdResultLabel.snp.bottom).offset(4)
            make.centerX.equalTo(eighthdResultLabel.snp.centerX)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        configureNavigationBar()
        configurePickerView()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "LOTTERY"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .lotteryGray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configurePickerView() {
        lotteryPickerView.delegate = self
        lotteryPickerView.dataSource = self
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roundTextField.text = "\(numberList[row])회차"
        networkService(numberList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
