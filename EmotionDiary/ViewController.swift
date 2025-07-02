//
//  ViewController.swift
//  EmotionDiary
//
//  Created by Suji Jang on 7/1/25.
//

import UIKit

class ViewController: UIViewController {

    var angryCount = 0
    
    // 아웃렛 컬렉션으로 관리해보기
    @IBOutlet var happyLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var loveLabel: UILabel!
    
    @IBOutlet var angryLabel: UILabel!
    @IBOutlet var boredLabel: UILabel!
    @IBOutlet var stuffyLabel: UILabel!
    
    @IBOutlet var panicLabel: UILabel!
    @IBOutlet var patheticLabel: UILabel!
    @IBOutlet var sadLabel: UILabel!
    
    @IBOutlet var happyButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var loveButton: UIButton!
    
    @IBOutlet var angryButton: UIButton!
    @IBOutlet var boredButton: UIButton!
    @IBOutlet var stuffyButton: UIButton!
    
    @IBOutlet var panicButton: UIButton!
    @IBOutlet var patheticButton: UIButton!
    @IBOutlet var sadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        designLabelUI(label: happyLabel, text: "행복해", count: 0)
        designLabelUI(label: likeLabel, text: "좋아해", count: 0)
        designLabelUI(label: loveLabel, text: "사랑해", count: 0)
        
        designLabelUI(label: angryLabel, text: "화가나", count: 0)
        designLabelUI(label: boredLabel, text: "심심해", count: 0)
        designLabelUI(label: stuffyLabel, text: "답답해", count: 0)
        
        designLabelUI(label: panicLabel, text: "당황해", count: 0)
        designLabelUI(label: patheticLabel, text: "한심해", count: 0)
        designLabelUI(label: sadLabel, text: "속상해", count: 0)
        
        designButtonUI(button: happyButton, image: "mono_slime1")
        designButtonUI(button: likeButton, image: "mono_slime2")
        designButtonUI(button: loveButton, image: "mono_slime3")
        
        designButtonUI(button: angryButton, image: "mono_slime4")
        designButtonUI(button: boredButton, image: "mono_slime5")
        designButtonUI(button: stuffyButton, image: "mono_slime6")
        
        designButtonUI(button: panicButton, image: "mono_slime7")
        designButtonUI(button: patheticButton, image: "mono_slime8")
        designButtonUI(button: sadButton, image: "mono_slime9")
        
        
    }

    func designLabelUI(label: UILabel, text: String, count: Int) {
        label.text = "\(text) \(String(count))"
        label.textAlignment = .center
    }
    
    func designButtonUI(button: UIButton, image: String) {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: image), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
    }
    
    @IBAction func happyButtonTapped(_ sender: UIButton) {
        let count = Int.random(in: 1...10)
        designLabelUI(label: happyLabel, text: "행복해", count: count)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        designLabelUI(label: likeLabel, text: "좋아해", count: Int.random(in: 1...10))
    }
    
    @IBAction func loveButtonTapped(_ sender: UIButton) {
        designLabelUI(label: loveLabel, text: "사랑해", count: Int.random(in: 1...10))
    }
    
    @IBAction func angryButtonTapped(_ sender: UIButton) {
        angryCount += 1
        designLabelUI(label: angryLabel, text: "화가나", count: angryCount)
    }
    
    @IBAction func boredButtonTapped(_ sender: UIButton) {
        designLabelUI(label: boredLabel, text: "심심해", count: Int.random(in: 1...10))
    }
    
    @IBAction func stuffyButtonTapped(_ sender: UIButton) {
        designLabelUI(label: stuffyLabel, text: "답답해", count: Int.random(in: 1...10))
    }
    
    @IBAction func panicButtonTapped(_ sender: UIButton) {
        designLabelUI(label: panicLabel, text: "당황해", count: Int.random(in: 1...10))
    }
    
    @IBAction func patheticButtonTapped(_ sender: UIButton) {
        designLabelUI(label: patheticLabel, text: "한심해", count: Int.random(in: 1...10))
    }
    
    @IBAction func sadButtonTapped(_ sender: UIButton) {
        designLabelUI(label: sadLabel, text: "속상해", count: Int.random(in: 1...10))
    }
}

// 열거형사용해서 안전하게
