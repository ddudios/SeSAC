//
//  PhotoDetailViewController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController {
    
    private lazy var likeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let detailImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let sectionTitleLabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .Heading.bold18
        label.textColor = .black
        return label
    }()
    
    private let infoFirstCategoryTitleLabel = {
        let label = UILabel()
        label.text = "크기"
        label.font = .Heading.bold16
        label.textColor = .black
        return label
    }()
    
    private let sizeLabel = {
        let label = UILabel()
        label.text = "3098 x 2020"
        label.font = .Prominent.medium14
        label.textColor = .black
        return label
    }()
    
    private let infoSecondCategoryTitleLabel = {
        let label = UILabel()
        label.text = "조회수"
        label.font = .Heading.bold16
        label.textColor = .black
        return label
    }()
    
    private let viewsTotalLabel = {
        let label = UILabel()
        label.text = "1,232,323"
        label.font = .Prominent.medium14
        label.textColor = .black
        return label
    }()
    
    private let infoThirdCategoryTitleLabel = {
        let label = UILabel()
        label.text = "다운로드"
        label.font = .Heading.bold16
        label.textColor = .black
        return label
    }()
    
    private let downloadsTotalLabel = {
        let label = UILabel()
        label.text = "12,323"
        label.font = .Prominent.medium14
        label.textColor = .black
        return label
    }()
    
    private let viewModel = PhotoDetailViewModel()
    var id: String = ""
    var imageString: String = ""
    var imageSize: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.viewDidLoad.data = id
        let url = URL(string: imageString)
        detailImageView.kf.setImage(with: url)
        sizeLabel.text = imageSize
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.viewDidLoad.data = id
    }
    
    private func bindData() {
        viewModel.output.info.bind { data in
            let viewTotal = data.views?.total ?? 0
            let downloadTotal = data.downloads?.total ?? 0
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            if let formatted = formatter.string(from: NSNumber(value: viewTotal)) {
                self.viewsTotalLabel.text = formatted
            }
            
            if let formatted = formatter.string(from: NSNumber(value: downloadTotal)) {
                self.downloadsTotalLabel.text = formatted
            }
        }
        
        viewModel.output.like.bind { [weak self] data in
            guard let self else { return }
            if data {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @objc func likeButtonTapped() {
        viewModel.input.likeButtonTapped.data = ()
    }
    
    override func configureHierarcy() {
        view.addSubview(likeButton)
        view.addSubview(detailImageView)
        view.addSubview(sectionTitleLabel)
        view.addSubview(infoFirstCategoryTitleLabel)
        view.addSubview(infoSecondCategoryTitleLabel)
        view.addSubview(infoThirdCategoryTitleLabel)
        view.addSubview(sizeLabel)
        view.addSubview(viewsTotalLabel)
        view.addSubview(downloadsTotalLabel)
    }
    
    override func configureLayout() {
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(50)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        infoFirstCategoryTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sectionTitleLabel.snp.centerY)
            make.leading.equalTo(sectionTitleLabel.snp.trailing).offset(60)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sectionTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        infoSecondCategoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoFirstCategoryTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(sectionTitleLabel.snp.trailing).offset(60)
        }
        
        viewsTotalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoSecondCategoryTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        infoThirdCategoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoSecondCategoryTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(sectionTitleLabel.snp.trailing).offset(60)
        }
        
        downloadsTotalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoThirdCategoryTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
