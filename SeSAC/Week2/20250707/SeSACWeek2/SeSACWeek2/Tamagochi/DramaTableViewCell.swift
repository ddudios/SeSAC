//
//  DramaTableViewCell.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/10/25.
//

import UIKit

// 아웃렛 명만 설정하는 곳: 이름 때문에 존재
// 변경되지 않을 셀 디자인
class DramaTableViewCell: UITableViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .brown
        overviewLabel.font = .boldSystemFont(ofSize: 20)
        posterImageView.backgroundColor = .orange
    }
    
    // 재사용하기 전에 준비
    // 셀을 재사용하는 시점에 호출됨
    // 이전 셀에 남아있는 흔적 지움
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        
        // 개발자들이 읽을 때, 초기 셋팅이 이거구나 라고 생각할 수 있음
        // 지금 작성하는 공간이 cell이여서 cell.background에서 cell.생략 가능
        backgroundColor = .white
    }
}
