//
//  OtherMessageTableViewCell.swift
//  Travel
//
//  Created by Suji Jang on 7/20/25.
//

import UIKit

class OtherMessageTableViewCell: UITableViewCell {

    @IBOutlet var dateDividerButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var messageBackgroundView: UIView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        profileImageView.backgroundColor = .clear
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        
        nameLabel.font = CustomFont.chatBody
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        messageBackgroundView.backgroundColor = .white
        messageBackgroundView.layer.borderColor = UIColor.systemGray2.cgColor
        messageBackgroundView.layer.borderWidth = 0.8
        messageBackgroundView.layer.cornerRadius = 14
        messageBackgroundView.clipsToBounds = true
        
        messageLabel.font = CustomFont.chatBody
        messageLabel.textColor = .black
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 0
        
        dateLabel.font = CustomFont.footnote
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .left
    }
    
    func configureData(_ row: Chat, changeDate: Bool = true) {
        profileImageView.image = UIImage(named: row.user.image)
        nameLabel.text = row.user.name
        messageLabel.text = row.message
        dateLabel.text = CustomDate.formattingHour(row.date)
        dateDividerButton.divider(CustomDate.formattingChangeDay(row.date), hidden: changeDate)
    }
}
