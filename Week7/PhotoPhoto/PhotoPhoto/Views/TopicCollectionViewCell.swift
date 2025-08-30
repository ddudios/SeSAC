//
//  GoldenHourCollectionViewCell.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/16/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TopicCollectionViewCell: BaseCollectionViewCell {
    
    weak var overlayDelegate: PhotoOverlayViewDelegate? {
        didSet {
            photoOverlayView.delegate = overlayDelegate
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    private let photoOverlayView = PhotoOverlayView()
    
    override func configureHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(photoOverlayView)
    }
    
    override func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photoOverlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func configureView(imageURL: String, stars: Int, id: String) {
        backgroundImageView.kf.setImage(with: URL(string: imageURL))
        photoOverlayView.configure(stars: stars, isLiked: UserDefaults.standard.bool(forKey: id), id: id)
    }
    
    func sendData(with model: Topic) {
        configureView(imageURL: model.urls.raw, stars: model.stars, id: model.id ?? "XWKP0yH2DeY")
    }
}
