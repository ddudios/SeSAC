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
    
    //MARK: 첫번째 데이터에 쓰레기값이 들어가고 있음 -> 빈배열로 시작하도록 개선
//    var list: NaverSearch = NaverSearch(total: 0, items: [Item(title: "", image: "", lprice: "", mallName: "")])
    var list: [Item] = []
    var searchText: String = ""
    var startPosition = 1
    var remainingData = 100
    var lastData = false

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest(query: searchText, sort: SortType.accuracy.rawValue)
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
    
    //MARK: - Selectors
    func callRequest(query: String, sort: String) {
        guard let url = URL(string: NaverShoppingService(query: query, sort: sort, start: startPosition).url) else {
            print("error: URL - \(#function)")
            return
        }
        let header: HTTPHeaders = [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { response in
            switch response.result {
            case .success(let value):
                self.totalLabel.text = "\(value.total) 개의 검색 결과"
                print(value)
                self.list = value.items
                
                self.collectionView.reloadData()
                
                if self.startPosition == 1 {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    self.remainingData = value.total
                }
            case .failure(let error):
                self.showAlert {
                    self.navigationController?.popViewController(animated: true)
                }
                print("error: \(error)")
            }
        }
    }
    
    //TODO: 하나로 합쳐보기
    @objc private func accuracySortButtonTapped() {
        accuracySortButton.buttonTapped(isActive: true)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
        callRequest(query: searchText, sort: SortType.accuracy.rawValue)
    }
    
    @objc private func dateSortButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: true)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
        callRequest(query: searchText, sort: SortType.date.rawValue)
    }
    
    @objc private func highPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: true)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
        callRequest(query: searchText, sort: SortType.high.rawValue)
    }
    
    @objc private func lowPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: true)
        list.removeAll()
        startPosition = 1
        callRequest(query: searchText, sort: SortType.low.rawValue)
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
                callRequest(query: searchText, sort: SortType.accuracy.rawValue)
            } else if dateSortButton.isTapped {
                callRequest(query: searchText, sort: SortType.date.rawValue)
            } else if highPriceSortButton.isTapped {
                callRequest(query: searchText, sort: SortType.high.rawValue)
            } else if lowPriceSortButton.isTapped {
                callRequest(query: searchText, sort: SortType.low.rawValue)
            } else {
                print("errer: \(#function)")
            }
        }
        remainingData -= 30
    }
}
