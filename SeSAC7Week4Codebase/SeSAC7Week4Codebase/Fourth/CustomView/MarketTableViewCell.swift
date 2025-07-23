//
//  MarketTableViewCell.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/23/25.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    
    static let identifier = "MarketTableViewCell"  // Cell꺼니까 타입프로퍼티로 셀 안에 지정
    let nameLabel = UILabel()

    /*
    // Nib Xib == Storyboard, InterfaceBuilder
        // 스토리보드가 있어야 실행되는 코드
    override func awakeFromNib() {
        super.awakeFromNib()
    }*/
    
    // 코드로 뷰를 구성했을 때 실행되는 코드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("코드 Init")
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    // 스토리보드로 뷰를 구성했을 때 실행되는 코드
//    required init?(coder: NSCoder) {}
    // 신경쓸 필요없지만 애플이 만들라고 강제
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        // view는 밑바탕 뷰
        // 유의사항. 보이고 레이아웃도 잘 잡히지만 잘못 추가한 것이다
            // TableViewCell과 ContentView 사이 어딘가에 생기는 것임, self생략가능 (보이긴 함)
            // 버튼같은 클릭되는 요소들은 클릭이 안됨
//        self.addSubview(nameLabel)
        // ⭐️ contentView
        contentView.addSubview(nameLabel)
    }
    
    func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(22)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureView() {
        nameLabel.text = "비트코인"
        nameLabel.textColor = .white
    }
    
    
}
