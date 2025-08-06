//
//  VerticalScrollViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/5/25.
//

import UIKit
import SnapKit

class VerticalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()  // 컨텐트뷰가 스크롤뷰 안에
    let contentView = UIView()
    
    // 스크롤뷰 입장에서는 기다란 UIView 하나만 관리하도록
        // 굳이 중간자가 없어도 되는데 내부 객체 3개 다 관리하는 것보다 하나관리하는게 편함
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIView에는 scrollView만,
        view.addSubview(scrollView)
        
        // scrollView에는 contentView만,
        scrollView.addSubview(contentView)
        
        // 나머지는 다 contentView가 관리하는 형태
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(button)
        
        scrollView.bouncesVertically = false
        scrollView.backgroundColor = .lightGray
        contentView.backgroundColor = .red
        label.backgroundColor = .orange
        imageView.backgroundColor = .black
        button.backgroundColor = .purple
        
        // 보통 스크롤이 화면 전체에서 일어나니까 화면 전체 스크롤할 수 있게
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(900)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(label.snp.bottom).offset(50)
            make.bottom.equalTo(imageView.snp.top).offset(-50)
        }
    }
}
