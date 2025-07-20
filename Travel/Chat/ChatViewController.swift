//
//  ChatViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/20/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    @IBOutlet private var chatTableView: UITableView!
    @IBOutlet private var textFieldBackgroundView: UIView!
    @IBOutlet private var messageTextField: UITextField!
    
    private let userMessageCellIdentifier = "UserMessageTableViewCell"
    private let otherMessageCellIdentifier = "OtherMessageTableViewCell"
    private var navigationTitle = ""
    private var numberOfRowsInSection = 10
    private var chatList = ChatList.list.first!.chatList
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .clear
        configureNavigationBarUI(title: navigationTitle)
        configureTableView()
        
        textFieldBackgroundView.backgroundColor = .systemGray6
        textFieldBackgroundView.layer.cornerRadius = 8
        textFieldBackgroundView.clipsToBounds = true
        
        messageTextField.backgroundColor = .systemGray6
        messageTextField.borderStyle = .none
        messageTextField.attributedPlaceholder = NSAttributedString(string: "메세지를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    private func configureTableView() {
        chatTableView.backgroundColor = .clear
        chatTableView.separatorStyle = .none
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        let userXib = UINib(nibName: userMessageCellIdentifier, bundle: nil)
        chatTableView.register(userXib, forCellReuseIdentifier: userMessageCellIdentifier)
        let otherXib = UINib(nibName: otherMessageCellIdentifier, bundle: nil)
        chatTableView.register(otherXib, forCellReuseIdentifier: otherMessageCellIdentifier)
    }
    
    func configureData(_ chatRoom: ChatRoom) {
        navigationTitle = chatRoom.chatroomName
        chatList = chatRoom.chatList
        numberOfRowsInSection = chatList.count
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chatList[indexPath.row]
        
        if row.user.name == ChatList.me.name {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: userMessageCellIdentifier, for: indexPath) as! UserMessageTableViewCell
            
            cell.configureData(row)
            
            return cell
        } else {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: otherMessageCellIdentifier, for: indexPath) as! OtherMessageTableViewCell
            
            DispatchQueue.main.async {
                cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
            }
            
            cell.configureData(row)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
