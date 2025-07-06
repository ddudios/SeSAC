//
//  NaverPayViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

class NaverPayViewController: UIViewController {
    
    enum CategorySet: String {
        case categoryTitle0 = "멤버십"
        case categoryTitle1 = "현장결제"
        case categoryTitle2 = "쿠폰"
    }
    
    enum CornerRadiusValue: CGFloat {
        case categoryButton = 17
        case button = 25
        case backgroundView = 20
        case agreeButton = 27
    }
    
    @IBOutlet var categoryBackgroundView: UIView!
    @IBOutlet var membershipCategoryButton: UIButton!
    @IBOutlet var paymentCategoryButton: UIButton!
    @IBOutlet var cuponCategoryButton: UIButton!
    
    @IBOutlet var closeButton: UIButton!
    
    @IBOutlet var paymentBackgroundView: UIView!
    @IBOutlet var paymentLogoImageView: UIImageView!
    @IBOutlet var paymentGlobalButton: UIButton!
    @IBOutlet var paymentRockImageView: UIImageView!
    @IBOutlet var paymentTitleLabel: UILabel!
    @IBOutlet var paymentCheckButton: UIButton!
    @IBOutlet var paymentAgreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .darkGray
        designCategoryBackgroundViewUI()
        designCategoryButonUI(membershipCategoryButton, title: CategorySet.categoryTitle0.rawValue)
        designCategoryButonUI(paymentCategoryButton, title: CategorySet.categoryTitle1.rawValue, toggle: true)
        designCategoryButonUI(cuponCategoryButton, title: CategorySet.categoryTitle2.rawValue)
        designPaymentBackgroundViewUI()
        designCloseButtonUI()
        designImageViewUI(paymentLogoImageView, imageName: "paymenLogoImage")
        designGlobalButtonUI()
        designImageViewUI(paymentRockImageView, imageName: "paymentRockImage")
        designPaymentTitleLabelUI()
        designPaymentCheckButtonUI()
        designAgreeButtonUI()
    }
    
    func designCategoryBackgroundViewUI() {
        categoryBackgroundView.backgroundColor = .black
        categoryBackgroundView.layer.cornerRadius = CornerRadiusValue.button.rawValue
    }
    
    func designCategoryButonUI(_ bt: UIButton, title: String, toggle: Bool = false) {
        bt.setTitle(title, for: .normal)
        bt.layer.cornerRadius = CornerRadiusValue.categoryButton.rawValue
        
        if toggle {
            bt.backgroundColor = .darkGray
            bt.setTitleColor(.white, for: .normal)
        } else {
            bt.backgroundColor = .black
            bt.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    func designCloseButtonUI() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .darkGray
        closeButton.setTitle("", for: .normal)
    }
    
    func designPaymentBackgroundViewUI() {
        paymentBackgroundView.layer.cornerRadius = CornerRadiusValue.backgroundView.rawValue
    }
    
    func designImageViewUI(_ imageView: UIImageView, imageName: String) {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
    }
    
    func designGlobalButtonUI() {
        paymentGlobalButton.backgroundColor = .white
        let title = NSAttributedString(string: "국내 ▼",
                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                                                    NSAttributedString.Key.foregroundColor: UIColor.gray])
        paymentGlobalButton.setAttributedTitle(title, for: .normal)
    }
    
    func designPaymentTitleLabelUI() {
        paymentTitleLabel.numberOfLines = 0
        paymentTitleLabel.text = """
            한 번만 인증하고
            비밀번호 없이 결제하세요
            """
        paymentTitleLabel.font = .boldSystemFont(ofSize: 20)
        paymentTitleLabel.textColor = .black
        paymentTitleLabel.textAlignment = .center
    }
    
    func designPaymentCheckButtonUI() {
        paymentCheckButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        paymentCheckButton.tintColor = .green
        paymentCheckButton.setTitle(" 바로결제 사용하기", for: .normal)
        paymentCheckButton.setTitleColor(.black, for: .normal)
    }
    
    func designAgreeButtonUI() {
        paymentAgreeButton.setTitle("확인", for: .normal)
        paymentAgreeButton.setTitleColor(.white, for: .normal)
        paymentAgreeButton.layer.cornerRadius = CornerRadiusValue.agreeButton.rawValue
        paymentAgreeButton.backgroundColor = .green
    }
 
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        if sender == membershipCategoryButton {
            designCategoryButonUI(membershipCategoryButton, title: CategorySet.categoryTitle0.rawValue, toggle: true)
            designCategoryButonUI(paymentCategoryButton, title: CategorySet.categoryTitle1.rawValue, toggle: false)
            designCategoryButonUI(cuponCategoryButton, title: CategorySet.categoryTitle2.rawValue, toggle: false)
            paymentBackgroundView.isHidden = true
        } else if sender == paymentCategoryButton {
            designCategoryButonUI(membershipCategoryButton, title: CategorySet.categoryTitle0.rawValue, toggle: false)
            designCategoryButonUI(paymentCategoryButton, title: CategorySet.categoryTitle1.rawValue, toggle: true)
            designCategoryButonUI(cuponCategoryButton, title: CategorySet.categoryTitle2.rawValue, toggle: false)
            paymentBackgroundView.isHidden = false
        } else if sender == cuponCategoryButton {
            designCategoryButonUI(membershipCategoryButton, title: CategorySet.categoryTitle0.rawValue, toggle: false)
            designCategoryButonUI(paymentCategoryButton, title: CategorySet.categoryTitle1.rawValue, toggle: false)
            designCategoryButonUI(cuponCategoryButton, title: CategorySet.categoryTitle2.rawValue, toggle: true)
            paymentBackgroundView.isHidden = true
        } else {
            print("error: categorybutton")
        }
    }
    
}
