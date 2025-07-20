//
//  FriendListCollectionViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/19/25.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    
    var customDate = CustomDate()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        profileImageView.backgroundColor = .clear
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = CustomFont.chatBody
        nameLabel.textColor = .black
        
        dateLabel.font = CustomFont.subhead
        dateLabel.textColor = .gray
        
        messageLabel.font = CustomFont.chatBody
        messageLabel.textColor = .gray
    }

    func configureData(_ item: ChatRoom) {
        profileImageView.image = UIImage(named: item.chatroomImage)
        nameLabel.text = item.chatroomName
        
        dateLabel.text = CustomDate.formattingDay(item.chatList.last?.date ?? "error: \(self) - \(#function)")
        
        messageLabel.text = item.chatList.last?.message
    }
}
