//
//  TopicViewController.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit
import SnapKit

final class TopicViewController: BaseViewController {
    //MARK: - Properties
    private lazy var profileButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "image1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.PhotoPhoto.signiture.cgColor
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let topicCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        
        // 헤더 등록
        collectionView.register(
            TopicCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TopicCollectionViewHeader.identifier
        )
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    let viewModel = TopicViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.reload.data = ()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topicCollectionView.reloadData()
    }
    
    //MARK: - Helpers
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileButton.layer.cornerRadius = profileButton.bounds.width / 2
    }
    
    private func bindData() {
        viewModel.output.topics.bind { [weak self] data in
            guard let self else { return }
            topicCollectionView.reloadData()
        }
    }
    
    @objc private func profileButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setCollectionView() {
        topicCollectionView.delegate = self
        topicCollectionView.dataSource = self
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "OUR TOPIC"
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    override func configureHierarcy() {
        view.addSubview(topicCollectionView)
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        topicCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        super.configureView()
        setNavigationBar()
        setCollectionView()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.output.topics.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.topics.data[section].topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as! TopicCollectionViewCell
        
        let item = viewModel.output.topics.data[indexPath.section].topics[indexPath.item]
        
        cell.sendData(with: item)
        cell.overlayDelegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopicCollectionViewHeader.identifier, for: indexPath) as! TopicCollectionViewHeader
        
        let sectionTitle = TopicId.allCases[indexPath.section].sectionTitle
        header.configure(title: sectionTitle)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        vc.id = viewModel.output.topics.data[indexPath.section].topics[indexPath.item].id ?? "XWKP0yH2DeY"
        vc.imageString = viewModel.output.topics.data[indexPath.section].topics[indexPath.item].urls.raw
        vc.imageSize = "\(viewModel.output.topics.data[indexPath.section].topics[indexPath.item].width) x \(viewModel.output.topics.data[indexPath.section].topics[indexPath.item].height)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - PhotoOverlayViewDelegate
extension TopicViewController: PhotoOverlayViewDelegate {
    func photoOverlayView(_ view: PhotoOverlayView, didTapLikeButton isLiked: Bool, id: String) {
//            isLiked ? UserDefaults.standard.set(false, forKey: id) : UserDefaults.standard.set(true, forKey: id)
    }
}
