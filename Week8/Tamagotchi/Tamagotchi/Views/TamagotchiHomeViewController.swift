//
//  ViewController.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class TamagotchiHomeViewController: BaseViewController {
    //MARK: - Properties
    private let damagochi = Tamagotchi(level: UserDefaults.standard.integer(forKey: "level"), rice: UserDefaults.standard.integer(forKey: "rice"), water: UserDefaults.standard.integer(forKey: "water"))
    private var nickname = UserDefaultsManager.shared.nickname/*UserDefaults.standard.string(forKey: "nickname") ?? "대장"*/

    @IBOutlet private var titleDivider: UIView!
    
    @IBOutlet private var navigationRightBarButton: UIBarButtonItem!
    
    @IBOutlet private var speechbubbleBackgroundView: UIView!
    @IBOutlet private var speechbubbleImageView: UIImageView!
    @IBOutlet private var talkLabel: UILabel!
    
    @IBOutlet private var damagochiImageView: UIImageView!
    @IBOutlet private var damagochiFeelingLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    
    @IBOutlet private var riceTextField: UITextField!
    @IBOutlet private var riceDivider: UIView!
    @IBOutlet private var riceButton: UIButton!
    
    @IBOutlet private var waterTextField: UITextField!
    @IBOutlet private var waterDiveder: UIView!
    @IBOutlet private var waterButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = TamagotchiHomeViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? "대장"
        self.navigationItem.title = "\(nickname)님의 다마고치"
        fetchTalk(nickname: nickname)
    }
    
    //MARK: - Helpers
    private func bind() {
        navigationRightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                let viewController = SettingViewController()
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func configureUI() {
        view.backgroundColor = .Tamagotchi.background
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
    
    func designSpeechbubbleUI() {
        speechbubbleBackgroundView.backgroundColor = .Tamagotchi.background
        speechbubbleImageView.image = UIImage(named: "bubble")
        
        talkLabel.textColor = .Tamagotchi.signiture
        talkLabel.numberOfLines = 0
        talkLabel.textAlignment = .center
        fetchTalk(nickname: nickname)
    }
    
    func designDamagochFeelingLabel() {
        damagochiFeelingLabel.text = "방실방실 다마고치"
        damagochiFeelingLabel.font = CustomFont.buttonTitle
        damagochiFeelingLabel.textColor = .Tamagotchi.signiture
        damagochiFeelingLabel.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        damagochiFeelingLabel.layer.borderWidth = 0.9
        damagochiFeelingLabel.layer.cornerRadius = 8
        damagochiFeelingLabel.clipsToBounds = true
        damagochiFeelingLabel.textAlignment = .center
    }

    func designStatusLabelUI() {
        fetchStatus()
        statusLabel.font = CustomFont.headline
        statusLabel.textAlignment = .center
        statusLabel.textColor = .Tamagotchi.signiture
    }
    
    func designFeedButtonUI(_ bt: UIButton, title: String, systemImage: String) {
        bt.backgroundColor = .Tamagotchi.background
        let title = NSAttributedString(string: title,
                                       attributes: [NSAttributedString.Key.font: CustomFont.buttonTitle,
                                                    NSAttributedString.Key.foregroundColor: UIColor.Tamagotchi.signiture])
        bt.setAttributedTitle(title, for: .normal)
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        bt.setImage(UIImage(systemName: systemImage), for: .normal)
        bt.tintColor = .Tamagotchi.signiture
        bt.configuration?.imagePadding = 3
    }
    
    func fetchStatus() {
        // level up
        let foodTotal = (Double(damagochi.rice) / 5) + (Double(damagochi.water) / 2)
        let level = Int(foodTotal) / 10
        if level > 10 {
            damagochi.level = 10
        } else if level > 0 && level < 10 {
            damagochi.level = level
        } else if level == 0 {
            damagochi.level = 1
        } else {
            print("error: \(#function) - level up")
        }
        
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
            print("error: \(#function) - image")
        }
        
        // save
        UserDefaults.standard.set(damagochi.level, forKey: "level")
        UserDefaults.standard.set(damagochi.rice, forKey: "rice")
        UserDefaults.standard.set(damagochi.water, forKey: "water")
    }
    
    func fetchTalk(nickname: String) {
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
        fetchTalk(nickname: nickname)
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
        fetchTalk(nickname: nickname)
        fetchStatus()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension TamagotchiHomeViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

