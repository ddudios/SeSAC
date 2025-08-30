//
//  SearchPhotoViewController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit
import SnapKit

final class SearchPhotoViewController: BaseViewController {
    //MARK: - Properties
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .white
        searchBar.searchTextField.leftView?.tintColor = UIColor.gray
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.searchTextField.clearButtonMode = .whileEditing
        return searchBar
    }()
    
    private lazy var filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private lazy var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("최신순", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = .systemBlue
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        return button
    }()
    
    private let placeholderLabel = {
        let label = UILabel()
        label.text = "사진을 검색해보세요."
        label.textColor = .black
        label.textAlignment = .center
        label.font = .Heading.bold18
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = SearchPhotoViewController.createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let filterTitles = ["블랙", "화이트", "옐로우", "레드", "퍼플", "그린", "블루"]
    private var selectedFilterIndex = 0
    
    var list: [SearchResult] = []
    var remainingData = 0
    var lastData = false
    var startPosition = 0
    
    let viewModel = SearchPhotoViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.reload.data = ()
        placeholderLabel.isHidden = false
        collectionView.isHidden = true
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    //MARK: - Helpers
    private func bindData() {
        viewModel.output.searchResult.bind { [weak self] data in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.placeholderLabel.isHidden = true
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    private func resetPagination() {
        startPosition = 0
        remainingData = 0
        lastData = false
        viewModel.output.searchResult.data.results.removeAll()
    }
    
    private func setupFilterButtons() {
         for (index, title) in filterTitles.enumerated() {
             let button = createFilterButton(title: title, isSelected: index == selectedFilterIndex)
             filterStackView.addArrangedSubview(button)
             button.tag = index
         }
     }
     
     private func createFilterButton(title: String, isSelected: Bool) -> UIButton {
         let button = UIButton()
         button.setTitle(title, for: .normal)
         button.titleLabel?.font = .Prominent.medium14
         button.layer.cornerRadius = 16
         
         if isSelected {
             button.backgroundColor = .PhotoPhoto.signiture
             button.setTitleColor(.white, for: .normal)
         } else {
             button.backgroundColor = .lightGray
             button.setTitleColor(.label, for: .normal)
         }
         
         button.contentEdgeInsets = UIEdgeInsets(top: 8, left:16, bottom: 8, right: 16)
         button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
         
         return button
     }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        if let previousButton = filterStackView.arrangedSubviews[selectedFilterIndex] as? UIButton {
            previousButton.backgroundColor = .lightGray
            previousButton.setTitleColor(.label, for: .normal)
        }
        
        selectedFilterIndex = sender.tag
        sender.backgroundColor = .PhotoPhoto.signiture
        sender.setTitleColor(.white, for: .normal)
        
        filter()
    }
    
    private func filter() {
        resetPagination()
        collectionView.reloadData()
    }
    
    private func setData(value: [SearchResult]) {
         if startPosition == 0 {
             self.list = value
             self.placeholderLabel.isHidden = true
             self.collectionView.isHidden = false
             self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
         } else {
             self.list.append(contentsOf: value)
         }
         
         self.remainingData = value.count
         self.collectionView.reloadData()
     }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.identifier)
    }
    
    override func configureHierarcy() {
        view.addSubview(searchBar)
        view.addSubview(filterScrollView)
        filterScrollView.addSubview(filterStackView)
        view.addSubview(sortButton)
        view.addSubview(placeholderLabel)
        view.addSubview(collectionView)
    }

    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        filterScrollView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(sortButton.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(filterScrollView)
            make.trailing.equalToSuperview().inset(16)
            make.width.greaterThanOrEqualTo(60)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterScrollView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    
    override func configureView() {
        super.configureView()
        navigationItem.title = "SEARCH PHOTO"
        navigationItem.backButtonDisplayMode = .minimal
        
        setSearchBar()
        setCollectionView()
        setupFilterButtons()
    }
}

//MARK: - UISearchBarDelegate
extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.textField.data = searchBar.text!
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.searchResult.data.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.identifier, for: indexPath) as! SearchPhotoCollectionViewCell
        
        let item = viewModel.output.searchResult.data.results[indexPath.item]
        
        cell.configure(with: item)
        cell.overlayDelegate = self
        print(item.id, UserDefaults.standard.bool(forKey: item.id!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        
        guard let imageUrl = viewModel.output.searchResult.data.results[indexPath.item].urls?.raw,
              let width = viewModel.output.searchResult.data.results[indexPath.item].width,
              let height = viewModel.output.searchResult.data.results[indexPath.item].height else { return }
        
        vc.id = viewModel.output.searchResult.data.results[indexPath.item].id ?? "XWKP0yH2DeY"
        vc.imageString = imageUrl
        vc.imageSize = "\(width) x \(height)"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            if remainingData < 1 {
                lastData = true
            }
        
        if indexPath.item == (viewModel.output.searchResult.data.results.count - 6) && lastData == false {
            startPosition += 20
            if let lastQuery = searchBar.text, !lastQuery.isEmpty {
                viewModel.input.textField.data = lastQuery
            }
        }
            remainingData -= 20
    }
}

//MARK: - PhotoOverlayViewDelegate
extension SearchPhotoViewController: PhotoOverlayViewDelegate {
    func photoOverlayView(_ view: PhotoOverlayView, didTapLikeButton isLiked: Bool, id: String) {
        isLiked ? UserDefaults.standard.set(false, forKey: id) : UserDefaults.standard.set(true, forKey: id)
    }
}
