//
//  CustomUILabel.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit

class CategoryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.body1
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.body4
        textColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 왜 순환참조 일어나는지 생각해보기
//class TitleLabel: UILabel {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        font = UIFont.heading1
//        textColor = .systemOrange
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "913회 당첨결과"
        font = UIFont.title1
        textColor = .systemOrange
        if let title = self.text {
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: (title as NSString).range(of: "당첨결과"))
            self.attributedText = attributedString
        } else {
            print("error: \(#function)")
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ResultLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.body1Prominent
        textColor = .white
        textAlignment = .center
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
        }
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BonusLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "보너스"
        textColor = .black
        font = UIFont.body4
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoxOfficeCellNumberLabel: UILabel {
    //MARK: 이건 어떻게 하는거지..
//    var numberText: String
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        textColor = .white
        self.layer.cornerRadius = 8
        clipsToBounds = true
        textAlignment = .center
        font = UIFont.body2Prominent
//        text = numberText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoxOfficeMovieNameLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.body1Prominent
        textColor = .black
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoxOfficeDateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.body4
        textColor = .black
        textAlignment = .right
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
