//
//  CustomLabel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 7/26/25.
//

import UIKit

final class EmptySearchBarTextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        font = UIFont.Heading.bold18
        textAlignment = .center
        text = "쇼핑하구팡"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SearchResultTotalLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        font = UIFont.Heading.bold16
        textColor = UIColor.naverSigniture
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class MallNameLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        font = UIFont.Body.regular12
        textColor = .white
        self.text = text
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SearchResultTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        font = UIFont.Body.regular14
        textColor = .white
        textAlignment = .left
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LpriceLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        font = UIFont.Prominent.medium16
        textColor = .white
        self.text = text
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
