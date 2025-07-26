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
    
    // titleLabel이 만들어지는 시점보다 이 함수가 먼저 만들어져 있어야지 titleLabel의 title을 받아와서 가공한 후 표시해줄 수 있다
    static func filter(title: String) -> String {
        print(title)
        var text = title
        if let range = text.range(of: "<b>", options: .caseInsensitive) {
            text.removeSubrange(range)
            if let range = text.range(of: "</b>", options: .caseInsensitive) {
                text.removeSubrange(range)
                return text
            }
        }
        return text
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
