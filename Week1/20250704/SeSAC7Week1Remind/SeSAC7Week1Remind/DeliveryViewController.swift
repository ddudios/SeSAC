//
//  DeliveryViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Suji Jang on 7/7/25.
//

import UIKit

class DeliveryViewController: UIViewController {

    @IBOutlet var deliveryBackgroundView: UIView!
    @IBOutlet var quickBackgroundView: UIView!
    
    @IBOutlet var togoBackgroundView: UIView!
    
    @IBOutlet var marketBackgroundView: UIView!
    @IBOutlet var liveBackgroundView: UIView!
    @IBOutlet var giftBackgroundView: UIView!
    @IBOutlet var hotplaceBackground: UIView!
    
    @IBOutlet var advertisementBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        designButtonUI(deliveryBackgroundView)
        designButtonUI(quickBackgroundView)
        designButtonUI(togoBackgroundView)
        designButtonUI(marketBackgroundView)
        designButtonUI(liveBackgroundView)
        designButtonUI(giftBackgroundView)
        designButtonUI(hotplaceBackground)
        designButtonUI(advertisementBackgroundView)
    }
    
    func designButtonUI(_ imageView: UIView) {
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
    }
}
