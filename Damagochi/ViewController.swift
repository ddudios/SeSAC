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

class ViewController: UIViewController {
    
    let customFont = CustomFont()

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
        statusLabel.text = "LV1 ∙ 밥알 0개 ∙ 물방울 0개"
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
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let backgroundColor =
    UIColor.rgb(red: 246, green: 252, blue: 252)
    static let mainColor = UIColor.rgb(red: 74, green: 99, blue: 112)
}
