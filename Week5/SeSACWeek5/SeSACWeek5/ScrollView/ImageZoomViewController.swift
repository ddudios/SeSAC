//
//  ImageZoomTableViewCell.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/5/25.
//

import UIKit
import SnapKit

class ImageZoomViewController: UIViewController {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true  // 인터렉션이 켜지고, 제스쳐 인식을 위해서
        return view
    }()
    
    let scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.showsVerticalScrollIndicator = false  // 스크롤할 때 막대바 Indicator를 보여줄지/말지 설정
        view.showsHorizontalScrollIndicator = true
        
        // 스크롤뷰 안에 들어있는 컨텐츠를 몇배 키워줄건지 최소는 얼마나 들어갈건지 배수 설정
        view.minimumZoomScale = 1  // 더이상 안줄어듬
        view.maximumZoomScale = 5  // 밑도끝도없이 무작정 커지는게 아니라, 어느정도 커졌을 때 더이상 안커짐
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.delegate = self
        
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)  // edge설정하면 확대 축소 불가능
            // scrollView 안쪽에 잡는게 중요
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2  // 더블탭
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapGesture() {
        print(#function)
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
