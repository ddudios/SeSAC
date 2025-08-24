//
//  Label.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/25/25.
//

import UIKit
import SnapKit

final class NameView: UIView {
    
    let nameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .Tamagotchi.signiture
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String) {
        super.init(frame: .zero)
        
        backgroundColor = .Tamagotchi.background
        layer.borderColor = UIColor.Tamagotchi.signiture.cgColor
        layer.borderWidth = 1
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview().inset(4)
        }
        nameLabel.text = name
    }
}
