//
//  CustomImageView.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/24/25.
//

import UIKit

class BoxOfficeBackgroundImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "boxofficeBackgroundImage")
        self.alpha = 0.5
//        self.layer.opacity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
