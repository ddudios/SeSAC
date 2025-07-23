//
//  LotteryViewController.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class LotteryViewController: UIViewController {

    private let roundTextField = PickerTextField()
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
}

//MARK: - ViewDesignProtocol
extension LotteryViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(roundTextField)
        view.addSubview(categoryLabel)
        view.addSubview(separatorView)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(resultStackView)
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
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "LOTTERY"
        
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
}
