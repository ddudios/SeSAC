//
//  kakaoProfileViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

class kakaoProfileViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var giftButton: UIButton!
    @IBOutlet var qrButton: UIButton!
    @IBOutlet var settingButton: UIButton!
    
    @IBOutlet var profilePhotoImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var kakaostoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        designBackgroundImageViewUI()
        designBarButtonUI(closeButton, imageName: "xmark")
        designBarButtonUI(giftButton, imageName: "gift.circle")
        designBarButtonUI(qrButton, imageName: "qrcode.viewfinder")
        designBarButtonUI(settingButton, imageName: "gearshape.circle")
        designProfilePhotoImageViewUI()
        designProfileNameLabelUI()
        designViewOpenButtonUI(chatButton, title: "나와의 채팅", image: "message.fill")
        designViewOpenButtonUI(editProfileButton, title: "프로필 편집", image: "pencil")
        designViewOpenButtonUI(kakaostoryButton, title: "카카오스토리", image: "quote.closing")
    }
    
    func designBackgroundImageViewUI() {
        backgroundImageView.image = UIImage(named: "profileBackgroundImage")
        backgroundImageView.layer.opacity = 0.5
    }
    
    func designBarButtonUI(_ bt: UIButton, imageName: String) {
        bt.setImage(UIImage(systemName: imageName), for: .normal)
        bt.tintColor = .gray
        bt.setTitle("", for: .normal)
    }
    
    func designProfilePhotoImageViewUI() {
        profilePhotoImageView.image = UIImage(named: "cat")
        profilePhotoImageView.layer.cornerRadius = 35
        profilePhotoImageView.contentMode = .scaleAspectFit
    }
    
    func designProfileNameLabelUI() {
        profileNameLabel.text = "수지"
        profileNameLabel.textColor = .gray
        profileNameLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    func designViewOpenButtonUI(_ bt: UIButton, title: String, image: String) {
        let titleDesign = NSAttributedString(string: title,
                                       attributes: [
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                                                    NSAttributedString.Key.foregroundColor: UIColor.gray
                                                   ])
        bt.setAttributedTitle(titleDesign, for: .normal)
        bt.setImage(UIImage(systemName: image), for: .normal)
        bt.tintColor = .gray
        bt.configuration?.imagePlacement = .top
        bt.configuration?.imagePadding = 10
    }
}
