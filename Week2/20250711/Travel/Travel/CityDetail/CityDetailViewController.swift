//
//  CityDetailViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionLabel: UILabel!
    @IBOutlet var goOtherCityButton: UIButton!
    
    var travel: Travel = Travel(title: "", description: nil, travel_image: nil, grade: nil, save: nil, like: nil, ad: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureNavigationBarUI(title: "관광지 화면")
        configureImageView(cityImageView)
        configureTitleLabel(cityNameLabel)
        configureDescriptionLabel(cityDescriptionLabel)
        configureButton(goOtherCityButton, text: "다른 관광지 보러 가기")
    }
    
    func configureImageView(_ imageView: UIImageView) {
        let url = URL(string:  travel.travel_image ?? "")
        imageView.kf.setImage(with: url)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
    }
    
    func configureTitleLabel(_ label: UILabel) {
        label.text = travel.title
        label.font = CustomFont.headline1
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func configureDescriptionLabel(_ label: UILabel) {
        label.text = travel.description
        label.font = CustomFont.title1
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    func configureButton(_ button: UIButton, text: String) {
        button.backgroundColor = UIColor.babyBlue
        button.layer.cornerRadius = 18
        
        let title = NSAttributedString(string: text,
                                       attributes: [NSAttributedString.Key.font: CustomFont.body,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white])
        button.setAttributedTitle(title, for: .normal)
    }
    
    @IBAction func goOtherCityButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
