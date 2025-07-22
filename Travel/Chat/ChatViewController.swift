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
    @IBOutlet private var sendButton: UIButton!
    
    private let userMessageCellIdentifier = "UserMessageTableViewCell"
    private let otherMessageCellIdentifier = "OtherMessageTableViewCell"
    private let dateDividerCellIdentifier = "DateDividerTableViewCell"
    private var navigationTitle = ""
    private var numberOfRowsInSection = 10
    private var chatList = ChatList.list.first!.chatList
//    private var lastDate = ""
    
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
        
        fetchScroll()
    }
    
    func configureData(_ chatRoom: ChatRoom) {
        navigationTitle = chatRoom.chatroomName
        chatList = chatRoom.chatList
        numberOfRowsInSection = chatList.count
    }
    
    private func fetchScroll() {
        DispatchQueue.main.async {
            self.chatTableView.scrollToRow(at: IndexPath(row: self.chatList.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    @objc
    private func sendButtonTapped() {
        chatList.append(Chat(user: ChatList.me, date: CustomDate.chattingDateForm(Date()), message: messageTextField.text ?? ""))
        
        numberOfRowsInSection += 1
        messageTextField.text = ""
        chatTableView.reloadData()
        fetchScroll()
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chatList[indexPath.row]
        var lastDate = ""
        if indexPath.row > 0 {
            lastDate = CustomDate.formattingDay(chatList[indexPath.row - 1].date)
        } else {
            lastDate = CustomDate.formattingDay(row.date)
        }
        
        if row.user.name == ChatList.me.name {
            print("cell생성전(lastDate:currentDate): \(lastDate) == \(CustomDate.formattingDay(row.date)): \(lastDate == CustomDate.formattingDay(row.date))")
            
            let cell = chatTableView.dequeueReusableCell(withIdentifier: userMessageCellIdentifier, for: indexPath) as! UserMessageTableViewCell
            
            
            print("생성중인Cell: \(indexPath.row)")
            if lastDate == CustomDate.formattingDay(row.date) {
                cell.configureData(row)
            } else {
                cell.configureData(row, changeDate: false)
            }
//            lastDate = CustomDate.formattingDay(row.date)
            
            sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
             /*
             // 왜 123465?????
            if lastDate == CustomDate.formattingDay(row.date) {
                cell.configureData(row)
            } else {
                cell.configureData(row, changeDate: false)
            }
            lastDate = CustomDate.formattingDay(row.date)
            
            sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
            */
            print("cell생성끝(lastDate:currentDate): \(lastDate) == \(CustomDate.formattingDay(row.date)): \(lastDate == CustomDate.formattingDay(row.date))")
            
            
            return cell
        } else {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: otherMessageCellIdentifier, for: indexPath) as! OtherMessageTableViewCell
            
            print("\(indexPath.row) Other(lastDate:currentDate)\(lastDate) == \(CustomDate.formattingDay(row.date)): \(lastDate == CustomDate.formattingDay(row.date))")
            
            DispatchQueue.main.async {
                cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
            }
            
            if lastDate == CustomDate.formattingDay(row.date) {
                cell.configureData(row)
            } else {
                cell.configureData(row, changeDate: false)
            }
//            lastDate = CustomDate.formattingDay(row.date)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
