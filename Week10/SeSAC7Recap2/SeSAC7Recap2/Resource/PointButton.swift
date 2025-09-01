//
//  PointButton.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit

class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.black
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
