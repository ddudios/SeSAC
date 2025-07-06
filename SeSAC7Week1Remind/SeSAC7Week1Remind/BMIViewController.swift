//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/6/25.
//

import UIKit

struct Contants {
    let mainTitleFont = UIFont.boldSystemFont(ofSize: 25)
    let subTitleFont = UIFont.systemFont(ofSize: 15)
    let pointFont = UIFont.boldSystemFont(ofSize: 20)
    let buttonFont = UIFont.systemFont(ofSize: 18)
    let footnoteFont = UIFont.systemFont(ofSize: 12)
    
    let image = "image"
    
    let cornerRadius: CGFloat = 15
}

class BMIViewController: UIViewController {
    
    let contants = Contants()
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextFieldView: UIView!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var secureButton: UIButton!
    
    @IBOutlet var randomBMIButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
    }
    
    func designUI() {
        designMainTitleLabelUI()
        designSubTitleLabelUI(subTitleLabel, text: """
당신의 BMI 지수를
알려드릴게요.
""")
        designImageViewUI()
        designResultLabelUI()
        designSubTitleLabelUI(heightLabel, text: "   키가 어떻게 되시나요?")
        designTextFieldUI(heightTextField)
        designSubTitleLabelUI(weightLabel, text: "   몸무게는 어떻게 되시나요?")
        designTextFieldViewUI(weightTextFieldView)
        designTextFieldUI(weightTextField, secure: true)
        designSecureButtonUI()
        designResultButtonUI()
        designRandomBMIButtonUI()
    }
    
    func designMainTitleLabelUI() {
        mainTitleLabel.text = "BMI Calculator"
        mainTitleLabel.textColor = .black
        mainTitleLabel.font = contants.mainTitleFont
        mainTitleLabel.textAlignment = .left
    }
    
    func designSubTitleLabelUI(_ label: UILabel, text: String) {
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = contants.subTitleFont
        
        let text = text
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
    }
    
    func designImageViewUI() {
        imageView.image = UIImage(named: contants.image)
    }
    
    func designResultLabelUI() {
        resultLabel.text = "정상"
        resultLabel.textColor = .black
        resultLabel.font = contants.pointFont
        resultLabel.textAlignment = .left
    }
    
    func designTextFieldUI(_ tf: UITextField, secure: Bool = false) {
        tf.tintColor = .black
        if secure {
            tf.backgroundColor = .white
            tf.borderStyle = .none
            tf.isSecureTextEntry = true
        } else {
            tf.backgroundColor = .white
            tf.layer.borderWidth = 1.3
            tf.layer.borderColor = UIColor.black.cgColor
            tf.layer.cornerRadius = contants.cornerRadius
        }
    }
    
    func designTextFieldViewUI(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.borderWidth = 1.3
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = contants.cornerRadius
    }
    
    func designSecureButtonUI() {
        secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        secureButton.setTitle("", for: .normal)
        secureButton.tintColor = .gray
    }
    
    func designRandomBMIButtonUI() {
        let title = NSAttributedString(string: "랜덤으로 BMI 계산하기",
                                       attributes: [
                                        NSAttributedString.Key.font: contants.footnoteFont,
                                                    NSAttributedString.Key.foregroundColor: UIColor.brown
                                                   ])
        randomBMIButton.setAttributedTitle(title, for: .normal)
    }
    
    func designResultButtonUI() {
        resultButton.backgroundColor = .purple
        let title = NSAttributedString(string: "결과 확인",
                                       attributes: [NSAttributedString.Key.font: contants.buttonFont,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white])
        resultButton.setAttributedTitle(title, for: .normal)
        resultButton.layer.cornerRadius = contants.cornerRadius
    }
}
