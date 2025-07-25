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
    var secureButtonToggle = false
    
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
    }
    
    // MARK: - Helpers
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
        resultLabel.text = ""
        resultLabel.textColor = .black
        resultLabel.font = contants.pointFont
        resultLabel.textAlignment = .left
    }
    
    func designTextFieldUI(_ tf: UITextField, secure: Bool = false) {
        tf.tintColor = .black
        tf.keyboardType = .numbersAndPunctuation
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
        secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
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
    
    func alert() {
        let invalidAlert = UIAlertController(title: "키 또는 몸무게를 확인하세요", message: "올바른 형식의 키와 몸무게를 입력해 주세요.", preferredStyle: UIAlertController.Style.alert)
        let confirm = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        invalidAlert.addAction(confirm)
        present(invalidAlert, animated: true, completion: nil)
    }
    
    // MARK: - Button Actions
    @IBAction func secureButtonTapped(_ sender: UIButton) {
        if secureButtonToggle {
            secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            weightTextField.isSecureTextEntry = true
        } else {
            secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
            weightTextField.isSecureTextEntry = false
        }
        secureButtonToggle.toggle()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        heightTextField.text = String(Int.random(in: 100...200))
        weightTextField.text = String(Int.random(in: 1...100))
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        let heightString = heightTextField.text
        let weightString = weightTextField.text
        
        guard let heightString,
              let weightString else {
            print("error: heightString, weightString")
            return
        }
        
        if heightString.isEmpty || weightString.isEmpty {
            alert()
        } else {
            
            guard let height = Double(heightString),
                  let weight = Double(weightString) else {
                print("error: height, weight Int 변환 실패")
                return
            }
            
            let bmi = weight / ((height * height) * 0.0001)
            var result = ""
            
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 1
            
            switch bmi {
            case ..<18.5:
                result = "저체중"
            case 18.5..<23:
                result = "정상"
            case 23..<25:
                result = "과체중"
            case 25..<30:
                result = "1단계 비만"
            case 30..<35:
                result = "2단계 비만"
            case 35...:
                result = "고도비만"
            default:
                alert()
            }
            
            resultLabel.text = "BMI: \(numberFormatter.string(from: bmi as NSNumber)!) (\(result))"
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - TextField Settings
    // 문자입력, 공백, 빈칸 처리
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let _ = Int(sender.text ?? "") else {
            sender.text = ""
            return
        }
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
    }
}
