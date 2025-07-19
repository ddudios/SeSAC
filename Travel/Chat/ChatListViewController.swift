//
//  FriendListViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/18/25.
//

import UIKit

class ChatListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    @IBOutlet private var searchView: UIView!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet var chatListCollectionView: UICollectionView!
    
    let chatListCellIdentifier = "ChatListCollectionViewCell"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        configureNavigationBarUI(title: "TRAVEL TALK")
        configureTextField()
    }
    
    private func configureTextField() {
        searchView.backgroundColor = .systemGray6
        searchView.layer.cornerRadius = 8
        searchView.clipsToBounds = true
        
        searchTextField.backgroundColor = .systemGray6
        searchTextField.tintColor = .black
        searchTextField.borderStyle = .none
        searchTextField.attributedPlaceholder = NSAttributedString(string: "친구 이름을 검색해 보세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray, NSAttributedString.Key.font: CustomFont.caption])
    }
    
    private func configureCollectionView() {
        chatListCollectionView.delegate = self
        chatListCollectionView.dataSource = self
        
        let xib = UINib(nibName: chatListCellIdentifier, bundle: nil)
        chatListCollectionView.register(xib, forCellWithReuseIdentifier: chatListCellIdentifier)
    }
    
    // MARK: - Selectors
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chatListCollectionView.dequeueReusableCell(withReuseIdentifier: chatListCellIdentifier, for: indexPath) as! ChatListCollectionViewCell
        return cell
    }
}
