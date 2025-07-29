//
//  SearchResultViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

enum SortType: String {
    case accuracy = "&sort=sim"
    case date = "&sort=date"
    case high = "&sort=dsc"
    case low = "&sort=asc"
}

final class SearchResultViewController: BaseViewController {
    
    private lazy var totalLabel = SearchResultTotalLabel(text: "0 개의 검색 결과")
    private lazy var accuracySortButton = SortButton(title: "  정확도  ", isActive: true)
    private lazy var dateSortButton = SortButton(title: "  날짜순  ")
    private lazy var highPriceSortButton = SortButton(title: "  가격높은순  ")
    private let lowPriceSortButton = SortButton(title: "  가격낮은순  ")
    private lazy var buttonStackView = {
        let stackView = UIStackView(arrangedSubviews: [accuracySortButton, dateSortButton, highPriceSortButton, lowPriceSortButton])
        stackView.axis = .horizontal
        stackView.spacing = ConstraintValue.CornerRadius.button
        stackView.alignment = .leading
        return stackView
    }()
    
    //MARK: 원래...안되는건지... 내가 못한건지....
    //    var collectionView = SearchResultCollectionViewUI()
    private let searchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let recommendationCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: recommendLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
        return collectionView
    }()
    
    var list: [Item] = []
    var searchText: String = ""
    var startPosition = 0
    var remainingData = 0
    var lastData = false
    
    var recommendationList: [Item] = []

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.totalLabel.text = "\(success.total) 개의 검색 결과"
            self.list.append(contentsOf: success.items)
            self.remainingData = success.total
            self.searchCollectionView.reloadData()
        } failure: {
            self.showAlert {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        NetworkManager.shared.callRequest(query: "키티", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.recommendationList = success.items
            self.recommendationCollectionView.reloadData()
        } failure: { }

    }
    
    //MARK: - Helpers
    override func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(buttonStackView)
        view.addSubview(searchCollectionView)
        view.addSubview(recommendationCollectionView)
    }
    
    override func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(ConstraintValue.edge)
            make.leading.equalToSuperview().offset(ConstraintValue.edge)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(totalLabel.snp.leading)
            make.top.equalTo(totalLabel.snp.bottom).offset(ConstraintValue.lineSpacing)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(buttonStackView.snp.bottom).offset(ConstraintValue.lineSpacing)
        }
        
        recommendationCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchCollectionView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(ConstraintValue.CollectionView.heightScope)
        }
    }
    
    override func configureView() {
        title = searchText
        configureCollectionView()
        
        accuracySortButton.addTarget(self, action: #selector(accuracySortButtonTapped), for: .touchUpInside)
        dateSortButton.addTarget(self, action: #selector(dateSortButtonTapped), for: .touchUpInside)
        highPriceSortButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        lowPriceSortButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
    }
    
    private func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
    }
    
    //MARK: - Selectors
    private func setData(value: NaverSearch) {
        self.totalLabel.text = "\(value.total) 개의 검색 결과"
        self.list.append(contentsOf: value.items)
        self.remainingData = value.total
        self.searchCollectionView.reloadData()
    }
    
    private func setOtherSortType(value: NaverSearch) {
        if self.startPosition == 1 {
            self.searchCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            self.remainingData = value.total
        }
    }
    
    //TODO: 하나로 합쳐보기
    @objc private func accuracySortButtonTapped() {
        accuracySortButton.buttonTapped(isActive: true)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.setData(value: success)
            self.setOtherSortType(value: success)
        } failure: {}
    }
    
    @objc private func dateSortButtonTapped() {
        print(#function)
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: true)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.date.rawValue, startPosition: 1) { success in
            self.setData(value: success)
            self.setOtherSortType(value: success)
        } failure: {}
    }
    
    @objc private func highPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: true)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.high.rawValue, startPosition: 1) { success in
            self.setData(value: success)
            self.setOtherSortType(value: success)
        } failure: {}
    }
    
    @objc private func lowPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: true)
        list.removeAll()
        startPosition = 1
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.low.rawValue, startPosition: 1) { success in
            self.setData(value: success)
            self.setOtherSortType(value: success)
        } failure: {}
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == searchCollectionView {
            return list.count
        } else if collectionView == recommendationCollectionView {
            return recommendationList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == searchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
            
            let item = list[indexPath.item]
            let url = URL(string: item.image)
            cell.imageView.kf.setImage(with: url)
            cell.mallNameLabel.text = item.mallName
            cell.titleLabel.text = SearchResultTitleLabel.filter(title: item.title)
//            let attribute = SearchResultTitleLabel.highlight(title: item.title, searchText: self.searchText)
//            cell.titleLabel.attributedText = attribute
            cell.lpriceLabel.text = item.lprice
            
            print(indexPath.item)
            return cell
        } else if collectionView == recommendationCollectionView {
            let cell = recommendationCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as! RecommendationCollectionViewCell
            
            let item = recommendationList[indexPath.item]
            let url = URL(string: item.image)
            cell.recommendImageView.kf.setImage(with: url)
            cell.titleLabel.text = SearchResultTitleLabel.filter(title: item.title)
            cell.titleLabel.text = item.title
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == searchCollectionView {
            if remainingData < 1 {
                lastData = true
            }
            //TODO: 하나로 개선해보기
            if indexPath.item == (list.count - 6) && lastData == false {
                startPosition += 30
                if accuracySortButton.isTapped {
                    NetworkManager.shared.callRequest(query: searchText, sort: SortType.accuracy.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if dateSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: searchText, sort: SortType.date.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if highPriceSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: searchText, sort: SortType.high.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if lowPriceSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: searchText, sort: SortType.low.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else {
                    print("errer: \(#function)")
                }
            }
            remainingData -= 30
        }
    }
}
