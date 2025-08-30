//
//  SearchPhotoCollectionViewCell.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchPhotoCollectionViewCell: BaseCollectionViewCell {
    
    weak var overlayDelegate: PhotoOverlayViewDelegate? {
        didSet {
            photoOverlayView.delegate = overlayDelegate
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private func configure(imageURL: String, stars: Int, id: String) {
        backgroundImageView.kf.setImage(with: URL(string: imageURL))
        photoOverlayView.configure(stars: stars, isLiked: UserDefaults.standard.bool(forKey: id), id: id)
    }
    
    func configure(with model: SearchResult) {
        configure(imageURL: model.urls?.raw ?? "https://images.unsplash.com/photo-1720623299754-f60843e74671?ixid=M3w3OTI1MDN8MHwxfHNlYXJjaHwyfHwlRUElQkQlODN8ZW58MHx8Mnx5ZWxsb3d8MTc1NTQ1ODcwNnww&ixlib=rb-4.1.0", stars: model.likes ?? 0, id: model.id ?? "XWKP0yH2DeY")
    }
}
