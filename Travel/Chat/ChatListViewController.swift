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
    @IBOutlet private var chatListCollectionView: UICollectionView!
    
    private let storyboardName = "Chat"
    private let chatListCellIdentifier = "ChatListCollectionViewCell"
    private let chatViewControllerIdentifier = "ChatViewController"
    var list = ChatList.list
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        configureNavigationBarUI(title: "TRAVEL TALK")
        configureTextField()
        configureCollectionView()
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
        
        chatListCollectionView.backgroundColor = .clear
        
        let xib = UINib(nibName: chatListCellIdentifier, bundle: nil)
        chatListCollectionView.register(xib, forCellWithReuseIdentifier: chatListCellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let itemWidth = deviceWidth - (20 * 2)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .vertical
        chatListCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - Selectors
    private func searchRoom() {
        var result: [ChatRoom] = []
        
        guard let text = searchTextField.text else {
            print("error: \(#function)")
            return
        }
        
        if text.isEmpty {
            list = ChatList.list
        } else {
            list.forEach { chatRoom in
                if chatRoom.chatroomName.contains(text) {
                    result.append(chatRoom)
                }
            }
            list = result
        }
    }
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chatListCollectionView.dequeueReusableCell(withReuseIdentifier: chatListCellIdentifier, for: indexPath) as! ChatListCollectionViewCell
        
        DispatchQueue.main.async {
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
        }
        
        let item = list[indexPath.item]
        cell.configureData(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: chatViewControllerIdentifier) as! ChatViewController
        viewController.configureData(list[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - TextField
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        searchRoom()
        chatListCollectionView.reloadData()
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: UITextField) {
    }
}
