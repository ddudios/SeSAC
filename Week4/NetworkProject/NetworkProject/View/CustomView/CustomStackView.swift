//
//  CustomStackView.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/24/25.
//

import UIKit

class LotteryResultStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        alignment = .fill
        distribution = .equalSpacing
        spacing = 4
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
