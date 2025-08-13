//
//  SearchResultViewController.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

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
    
    // 모든 데이터를 뷰모델에서 관리해보자!
    var list: [Item] = []
    var startPosition = 0
    var remainingData = 0
    var lastData = false
    
    var recommendationList: [Item] = []
    
    let viewModel = SearchResultViewModel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.viewDidLoadTrigger.data = ()
        bindData()
    }
    
    //MARK: - Helpers
    private func bindData() {
        viewModel.output.successData.bind { success in
            self.list = success.items
        }
        
        viewModel.output.title.bind { data in
            self.navigationItem.title = data
        }
        
        viewModel.output.total.bind { total in
            self.totalLabel.text = "\(total) 개의 검색 결과"
            print(self.viewModel.output.total.data)
            // 0 -> 1458981
            // 통신이 끝나는 시점과 화면이 그려지는 시점이 항상 다르기 때문에 값이 변하면 화면에 그려줘야 한다
        }
        
        viewModel.output.successData.bind { success in
            self.setData(value: success)
        }
        
        viewModel.output.networkingFailure.lazyBind { _ in
            self.showAlert {
                // 신호만 보내고 아웃풋으로 관리해보기
                self.navigationController?.popViewController(animated: true)
            }
            // bind로 만들면 일단 실행해버리니까 네트워킹 에러가 없어도 이 구문을 타버림
        }
        
        viewModel.output.recommendationDataList.bind { items in
            self.recommendationList = items
            self.recommendationCollectionView.reloadData()
        }
        
        viewModel.output.sortData.bind { success in
            self.setData(value: success)
            self.setOtherSortType(value: success)
            self.searchCollectionView.reloadData()
        }
    }
    
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
    
    private func readySort() {
        accuracySortButton.buttonTapped(isActive: false)
        dateSortButton.buttonTapped(isActive: false)
        highPriceSortButton.buttonTapped(isActive: false)
        lowPriceSortButton.buttonTapped(isActive: false)
        list.removeAll()
        startPosition = 1
    }
    
    @objc private func accuracySortButtonTapped() {
        readySort()
        accuracySortButton.buttonTapped(isActive: true)
        viewModel.input.sortButtonTapped.data = SortType.accuracy.rawValue
    }
    
    @objc private func dateSortButtonTapped() {
        readySort()
        dateSortButton.buttonTapped(isActive: true)
        viewModel.input.sortButtonTapped.data = SortType.date.rawValue
    }
    
    @objc private func highPriceButtonTapped() {
        readySort()
        highPriceSortButton.buttonTapped(isActive: true)
        viewModel.input.sortButtonTapped.data = SortType.high.rawValue
    }
    
    @objc private func lowPriceButtonTapped() {
        readySort()
        lowPriceSortButton.buttonTapped(isActive: true)
        viewModel.input.sortButtonTapped.data = SortType.low.rawValue
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
                    NetworkManager.shared.callRequest(query: viewModel.output.title.data ?? "", sort: SortType.accuracy.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if dateSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: viewModel.output.title.data ?? "", sort: SortType.date.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if highPriceSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: viewModel.output.title.data ?? "", sort: SortType.high.rawValue, startPosition: startPosition) { success in
                        self.setData(value: success)
                        self.setOtherSortType(value: success)
                    } failure: {}
                } else if lowPriceSortButton.isTapped {
                    NetworkManager.shared.callRequest(query: viewModel.output.title.data ?? "", sort: SortType.low.rawValue, startPosition: startPosition) { success in
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
