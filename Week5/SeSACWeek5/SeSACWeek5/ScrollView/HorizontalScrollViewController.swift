//
//  HorizontalScrollViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/5/25.
//

import UIKit
import SnapKit

class HorizontalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)  // 스크롤뷰 내부 컨텐츠의 엣지를 안잡는거지 스크롤뷰는 잡아줘야 함
        }
        
        // 수평
        stackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.edges.equalTo(scrollView)
        }
        
        configureLabel()
        stackView.spacing = 20
    }
    
    func configureLabel() {
            let label = UILabel()
            label.backgroundColor = .orange
            label.text = "slafdsafdsafdsafdafdsafdsafdsafdfsafdsa"
            stackView.addArrangedSubview(label)
            
            let label2 = UILabel()
            label2.backgroundColor = .brown
            label2.text = "slafds"
            stackView.addArrangedSubview(label2)
            
            let label3 = UILabel()
            label3.text = "33456"
            label3.backgroundColor = .blue
            label3.textColor = .white
            stackView.addArrangedSubview(label3)
            
            let label4 = UILabel()
            label4.text = "34354aasdfsadssafdsafdsa53456"
            label4.backgroundColor = .purple
            label4.textColor = .white
            stackView.addArrangedSubview(label4)
            
            let label5 = UILabel()
            label5.text = "3435453456"
            label5.backgroundColor = .green
            label5.textColor = .white
            stackView.addArrangedSubview(label5)

        }
}
