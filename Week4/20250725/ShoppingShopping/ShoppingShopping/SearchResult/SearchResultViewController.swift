//
//  SearchResultViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Alamofire
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
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.backgroundColor = .clear
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        return collectionView
    }()
    
    var list: [Item] = []
    var searchText: String = ""
    var startPosition = 0
    var remainingData = 0
    var lastData = false

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.callRequest(query: searchText, sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.totalLabel.text = "\(success.total) 개의 검색 결과"
            self.list.append(contentsOf: success.items)
            self.remainingData = success.total
            self.collectionView.reloadData()
        } failure: {
            self.showAlert {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: - Helpers
    override func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(buttonStackView)
        view.addSubview(collectionView)
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
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(buttonStackView.snp.bottom).offset(ConstraintValue.lineSpacing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setData(value: NaverSearch) {
        self.totalLabel.text = "\(value.total) 개의 검색 결과"
        self.list.append(contentsOf: value.items)
        self.remainingData = value.total
        self.collectionView.reloadData()
    }
    
    private func setOtherSortType(value: NaverSearch) {
        if self.startPosition == 1 {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
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
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let item = list[indexPath.item]
        let url = URL(string: item.image)
        cell.imageView.kf.setImage(with: url)
        cell.mallNameLabel.text = item.mallName
        cell.titleLabel.text = SearchResultTitleLabel.filter(title: item.title)
        print(item.title)
        print(SearchResultTitleLabel.filter(title: item.title))
        let attribute = SearchResultTitleLabel.highlight(title: item.title, searchText: self.searchText)
        cell.titleLabel.attributedText = attribute
        cell.lpriceLabel.text = item.lprice

        print(indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(remainingData, lastData)
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
