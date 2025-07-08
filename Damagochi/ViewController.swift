//
//  ViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

struct CustomFont {
    static let headline = UIFont.boldSystemFont(ofSize: 14)
    static let buttonTitle = UIFont.boldSystemFont(ofSize: 15)
}

struct CustomUI {
    static func designDividerUI(_ view: UIView, opacity: Float = 1) {
        view.backgroundColor = .mainColor
        view.layer.opacity = opacity
    }
    
    static func designTextFiledUI(_ tf: UITextField, placeholder: String, textAlignment: NSTextAlignment = .center, keyboardType: UIKeyboardType = .default) {
        tf.backgroundColor = .backgroundColor
        tf.borderStyle = .none
        tf.textAlignment = textAlignment
        tf.tintColor = .mainColor
        tf.keyboardType = keyboardType
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        tf.textColor = .mainColor
    }
}

class Damagochi {
    var level: Int = 1
    var rice: Int = 0
    var water: Int = 0
}

class ViewController: UIViewController {
    let damagochi = Damagochi()
    var nickname = UserDefaults.standard.string(forKey: "nickname") ?? "대장"

    @IBOutlet var titleDivider: UIView!
    
    @IBOutlet var speechbubbleBackgroundView: UIView!
    @IBOutlet var speechbubbleImageView: UIImageView!
    @IBOutlet var talkLabel: UILabel!
    
    @IBOutlet var damagochiImageView: UIImageView!
    @IBOutlet var damagochiFeelingLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "\(UserDefaults.standard.string(forKey: "nickname") ?? "대장")님의 다마고치"
        fetchTalk()
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        designNavigationBarUI()
        CustomUI.designDividerUI(titleDivider, opacity: 0.1)
        
        designSpeechbubbleUI()
        designDamagochFeelingLabel()
        designStatusLabelUI()
        
        CustomUI.designTextFiledUI(riceTextField, placeholder: "밥주세용", keyboardType: .numberPad)
        CustomUI.designDividerUI(riceDivider)
        designFeedButtonUI(riceButton, title: "밥먹기", systemImage: "leaf.circle")
        
        CustomUI.designTextFiledUI(waterTextField, placeholder: "물주세용", keyboardType: .numberPad)
        CustomUI.designDividerUI(waterDiveder)
        designFeedButtonUI(waterButton, title: "물먹기", systemImage: "drop.circle")
    }
    
    func designNavigationBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mainColor]
        appearance.backgroundColor = .backgroundColor
        navigationController?.navigationBar.tintColor = .mainColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func designSpeechbubbleUI() {
        speechbubbleBackgroundView.backgroundColor = .backgroundColor
        speechbubbleImageView.image = UIImage(named: "bubble")
        
        talkLabel.textColor = .mainColor
        talkLabel.numberOfLines = 0
        talkLabel.textAlignment = .center
        fetchTalk()
    }
    
    func designDamagochFeelingLabel() {
        damagochiFeelingLabel.text = "방실방실 다마고치"
        damagochiFeelingLabel.font = CustomFont.buttonTitle
        damagochiFeelingLabel.textColor = .mainColor
        damagochiFeelingLabel.layer.borderColor = UIColor.mainColor.cgColor
        damagochiFeelingLabel.layer.borderWidth = 0.9
        damagochiFeelingLabel.layer.cornerRadius = 8
        damagochiFeelingLabel.clipsToBounds = true
        damagochiFeelingLabel.textAlignment = .center
    }

    func designStatusLabelUI() {
        fetchStatus()
        statusLabel.font = CustomFont.headline
        statusLabel.textAlignment = .center
        statusLabel.textColor = .mainColor
    }
    
    func designFeedButtonUI(_ bt: UIButton, title: String, systemImage: String) {
        bt.backgroundColor = .backgroundColor
        let title = NSAttributedString(string: title,
                                       attributes: [NSAttributedString.Key.font: CustomFont.buttonTitle,
                                                    NSAttributedString.Key.foregroundColor: UIColor.mainColor])
        bt.setAttributedTitle(title, for: .normal)
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.mainColor.cgColor
        bt.setImage(UIImage(systemName: systemImage), for: .normal)
        bt.tintColor = .mainColor
        bt.configuration?.imagePadding = 3
    }
    
    func fetchStatus() {
        // level up
        let foodTotal = (Double(damagochi.rice) / 5) + (Double(damagochi.water) / 2)
        damagochi.level = Int(foodTotal) / 10
        
        // status
        statusLabel.text = "LV\(damagochi.level) ∙ 밥알 \(damagochi.rice)개 ∙ 물방울 \(damagochi.water)개"
        
        // image
        switch damagochi.level {
        case 0:
            damagochiImageView.image = UIImage(named: "2-1")
        case 1...9:
            damagochiImageView.image = UIImage(named: "2-\(String(damagochi.level))")
        case 10...:
            damagochiImageView.image = UIImage(named: "2-9")
        default:
            print("error: \(#function)")
        }
        
        // save
    }
    
    func fetchTalk() {
        let talk = [
            "복습 아직 안하셨다구요? 지금 잠이 오세여? \(nickname)님??",
            "\(nickname)님 오늘 깃허브 푸시 하셨어영?",
            "\(nickname)님, 밥주세요",
            "\(nickname)님, 물주세요",
            "좋은 하루에요, \(nickname)님",
            "밥과 물을 잘 먹었더니 레벨업 했어요 고마워요 \(nickname)님"
        ]
        
        talkLabel.text = talk.randomElement()
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
        fetchTalk()
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
        fetchTalk()
        fetchStatus()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension ViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let backgroundColor = UIColor.rgb(red: 246, green: 252, blue: 252)
    static let mainColor = UIColor.rgb(red: 74, green: 99, blue: 112)
}
