//
//  ViewController.swift
//  EmotionDiary
//
//  Created by Suji Jang on 7/1/25.
//

import UIKit

// 열거형 사용해서 안전하게
enum ImageName: String {
    case happy = "mono_slime1"
    case like = "mono_slime2"
    case love = "mono_slime3"
    case angry = "mono_slime4"
    case bored = "mono_slime5"
    case stuffy = "mono_slime6"
    case panic = "mono_slime7"
    case pathetic = "mono_slime8"
    case sad = "mono_slime9"
}

class ViewController: UIViewController {

    var emotionLabelText = ["행복해", "좋아해", "사랑해", "화가나", "심심해", "답답해", "당황해", "한심해", "속상해"]
    let emotionButtonImageName = [ImageName.happy.rawValue, ImageName.like.rawValue, ImageName.love.rawValue, ImageName.angry.rawValue, ImageName.bored.rawValue, ImageName.stuffy.rawValue, ImageName.panic.rawValue, ImageName.pathetic.rawValue, ImageName.sad.rawValue]
    
    var counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // 아웃렛 컬렉션으로 관리해보기
    @IBOutlet var emotionLabels: [UILabel]!
    @IBOutlet var emotionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        for index in 0...8 {
            designLabelUI(label: emotionLabels[index], text: emotionLabelText[index], count: 0)
            designButtonUI(button: emotionButtons[index], image: emotionButtonImageName[index])
        }
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
    
    @IBAction func getRandomNumber(_ sender: UIButton) {
        designLabelUI(label: emotionLabels[sender.tag], text: emotionLabelText[sender.tag], count: Int.random(in: 1...10))
    }
    
    @IBAction func countNumber(_ sender: UIButton) {
        counts[sender.tag] += 1
        designLabelUI(label: emotionLabels[sender.tag], text: emotionLabelText[sender.tag], count: counts[sender.tag])
    }
}
