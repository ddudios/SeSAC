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

final class SearchResultViewController: UIViewController {
    
    lazy var totalLabel = SearchResultTotalLabel(text: "0 개의 검색 결과")
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
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let itemWidth = deviceWidth - (ConstraintValue.CollectionView.sideSpacingQuantity * ConstraintValue.CollectionView.inset) - (ConstraintValue.CollectionView.itemSpacingQuantity * ConstraintValue.CollectionView.itemSpacing)
        layout.itemSize = CGSize(width: itemWidth/ConstraintValue.CollectionView.itemQuantity, height: ConstraintValue.CollectionView.height)
        layout.minimumLineSpacing = ConstraintValue.CollectionView.lineSpacing
        layout.minimumInteritemSpacing = ConstraintValue.CollectionView.itemSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: ConstraintValue.CollectionView.inset, left: ConstraintValue.CollectionView.inset, bottom: ConstraintValue.CollectionView.inset, right: ConstraintValue.CollectionView.inset)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        return collectionView
    }()
    
    var searchText: String = ""
    var numberOfItemsInSection = 0
    private lazy var url = URL(string: NaverShoppingService(query: searchText, sort: "").url)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(self)
        print(#function, numberOfItemsInSection)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function, numberOfItemsInSection)
        collectionView.reloadData()
    }
    
    //MARK: - Selectors
    private func getUrl(sort: String) -> URL? {
        return URL(string: NaverShoppingService(query: searchText, sort: sort).url)
    }
    
    @objc private func accuracySortButtonTapped() {
        accuracySortButton.buttonTapped(isActive: true)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        url = getUrl(sort: "&sort=sim")
        collectionView.reloadData()
    }
    
    @objc private func dateSortButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: true)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        url = getUrl(sort: "&sort=date")
        collectionView.reloadData()
    }
    
    @objc private func highPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: true)
        lowPriceSortButton.buttonTapped(isActive: false)
        url = getUrl(sort: "&sort=dsc")
        collectionView.reloadData()
    }
    
    @objc private func lowPriceButtonTapped() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: true)
        url = getUrl(sort: "&sort=asc")
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        guard let url else {
            print("error: URL - \(#function)")
            return UICollectionViewCell()
        }
        
        let header: HTTPHeaders = [
            APIKeyHeader.naverClientId.rawValue: Bundle.getAPIKey(for: .naverClientId),
            APIKeyHeader.naverClientSecret.rawValue: Bundle.getAPIKey(for: .naverClientSecret)
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: NaverSearch.self) { request in
            switch request.result {
            case .success(let value):
                let item = value.items[indexPath.item]
                let url = URL(string: item.image)
                cell.imageView.kf.setImage(with: url)
                cell.mallNameLabel.text = item.mallName
                cell.titleLabel.text = SearchResultTitleLabel.filter(title: item.title)
                cell.lpriceLabel.text = item.lprice
            case .failure(let error):
                print("fail: \(error)")
            }
        }
        
        return cell
    }
}

//MARK: - ViewDesignProtocol
extension SearchResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(buttonStackView)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
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
    
    func configureView() {
        setNavigationBar(self, title: searchText)
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
}
