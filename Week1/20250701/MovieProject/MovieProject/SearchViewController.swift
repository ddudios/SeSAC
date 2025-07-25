//
//  HotViewController.swift
//  MovieProject
//
//  Created by Suji Jang on 7/2/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var categoryButton: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designSearchTextFieldUI()
        
        for button in categoryButton {
            designButtonUI(button)
        }
    }
    
    func designSearchTextFieldUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "게임, 시리즈, 영화를 검색하세요...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
    }
    
    func designButtonUI(_ button: UIButton, active: Bool = false) {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        if active {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        designButtonUI(firstButton, active: false)
        designButtonUI(secondButton, active: false)
        designButtonUI(thirdButton, active: false)
        designButtonUI(sender, active: true)
        resultLabel.text = "\(sender.currentTitle!) 작품이 없습니다."
    }
}
