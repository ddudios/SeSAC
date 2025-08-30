//
//  PhotoView.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import UIKit
import SnapKit

protocol PhotoOverlayViewDelegate: AnyObject {
    func photoOverlayView(_ view: PhotoOverlayView, didTapLikeButton isLiked: Bool, id: String)
}

class PhotoOverlayView: UIView {
    weak var delegate: PhotoOverlayViewDelegate?
    
    var isLiked: Bool = false {
        didSet {
            updateLikeButton()
        }
    }
    
    var id = "XWKP0yH2DeY"
    
    var stars: Int = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            if let formatted = formatter.string(from: NSNumber(value: stars)) {
                starsLabel.text = formatted
            }
        }
    }
    
    private let starsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.clipsToBounds = true
        return view
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .Prominent.medium14
        label.text = "0"
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(stars: Int, isLiked: Bool, id: String) {
        self.init(frame: .zero)
        self.stars = stars
        self.isLiked = UserDefaults.standard.bool(forKey: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        starsContainerView.layer.cornerRadius = starsContainerView.frame.height / 2
        likeButton.layer.cornerRadius = likeButton.frame.height / 2
    }
    
    private func setupUI() {
        addSubview(starsContainerView)
        addSubview(likeButton)
        starsContainerView.addSubview(starImageView)
        starsContainerView.addSubview(starsLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        starsContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(32)
            make.width.greaterThanOrEqualTo(50)
        }
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        starsLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.height.equalTo(36)
        }
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        delegate?.photoOverlayView(self, didTapLikeButton: isLiked, id: id)
        print(id, isLiked, UserDefaults.standard.bool(forKey: id))
    }
    
    func configure(stars: Int, isLiked: Bool, id: String) {
        self.stars = stars
        self.isLiked = UserDefaults.standard.bool(forKey: id)
        self.id = id
    }
    
    private func updateLikeButton() {
        likeButton.tintColor = isLiked ? .PhotoPhoto.signiture : .white
        UserDefaults.standard.set(isLiked, forKey: self.id)
    }
}
