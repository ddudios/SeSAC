//
//  ViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

struct CustomFont {
    let headline = UIFont.boldSystemFont(ofSize: 14)
    let buttonTitle = UIFont.boldSystemFont(ofSize: 15)
}

class Damagochi {
    var level: Int = 1
    var rice: Int = 0
    var water: Int = 0
}

class ViewController: UIViewController {
    
    let customFont = CustomFont()
    let damagochi = Damagochi()

    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var riceDivider: UIView!
    @IBOutlet var riceButton: UIButton!
    
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterDiveder: UIView!
    @IBOutlet var waterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        designStatusLabelUI()
        
        designTextFiledUI(riceTextField, placeholder: "밥주세용")
        designDividerUI(riceDivider)
        designFeedButtonUI(riceButton, title: "밥먹기", systemImage: "leaf.circle")
        
        designTextFiledUI(waterTextField, placeholder: "물주세용")
        designDividerUI(waterDiveder)
        designFeedButtonUI(waterButton, title: "물먹기", systemImage: "drop.circle")
    }

    func designStatusLabelUI() {
        fetchStatus()
        statusLabel.font = customFont.headline
        statusLabel.textAlignment = .center
        statusLabel.textColor = .mainColor
    }
    
    func designTextFiledUI(_ tf: UITextField, placeholder: String) {
        tf.backgroundColor = .backgroundColor
        tf.borderStyle = .none
        tf.placeholder = placeholder
        tf.textAlignment = .center
        tf.tintColor = .mainColor
        tf.keyboardType = .numberPad
    }
    
    func designDividerUI(_ view: UIView) {
        view.backgroundColor = .mainColor
    }
    
    func designFeedButtonUI(_ bt: UIButton, title: String, systemImage: String) {
        bt.backgroundColor = .backgroundColor
        let title = NSAttributedString(string: title,
                                       attributes: [NSAttributedString.Key.font: customFont.buttonTitle,
                                                    NSAttributedString.Key.foregroundColor: UIColor.mainColor])
        bt.setAttributedTitle(title, for: .normal)
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.mainColor.cgColor
        bt.setImage(UIImage(systemName: systemImage), for: .normal)
        bt.tintColor = .mainColor
        bt.configuration?.imagePadding = 3
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func fetchStatus() {
        statusLabel.text = "LV\(damagochi.level) ∙ 밥알 \(damagochi.rice)개 ∙ 물방울 \(damagochi.water)개"
    }
    
    @IBAction func riceButtonTapped(_ sender: UIButton) {
        guard let rice = riceTextField.text else { return }
        
        if rice.isEmpty {
            damagochi.rice += 1
        } else if !rice.isEmpty {
            
            if let ea = Int(rice) {
                if ea < 100 {
                    damagochi.rice += ea
                } else {
                    alert(title: "밥알을 먹을 수 없습니다", message: "한 번에 먹을 수 있는 밥의 양은 99개까지 입니다.")
                }
            }
            
            riceTextField.text = ""
        } else {
            print("error: \(#function)")
        }
        
        fetchStatus()
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        guard let water = waterTextField.text else { return }
        
        if water.isEmpty {
            damagochi.water += 1
        } else if !water.isEmpty {
            
            if let ea = Int(water) {
                if ea < 50 {
                    damagochi.water += ea
                } else {
                    alert(title: "물을 먹을 수 없습니다", message: "한 번에 먹을 수 있는 물의 양은 49개까지 입니다.")
                }
            }
            
            waterTextField.text = ""
        } else {
            print("error: \(#function)")
        }
        
        fetchStatus()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let backgroundColor =
    UIColor.rgb(red: 246, green: 252, blue: 252)
    static let mainColor = UIColor.rgb(red: 74, green: 99, blue: 112)
}
