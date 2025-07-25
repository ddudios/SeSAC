//
//  TravelTableViewCell.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/14/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    // 인스턴스와 상관없게 만들어지기 때문에 인스턴스가 계속 생성되어도 이거는 생성되지 않음
    // Cell에 관련된 id이기 때문에 Cell에 만듦
    // Cell이 만들어질 때마다 생성되는 것이 아니라
    static let identifier = "TravelTableViewCell"

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var travelLabel: UILabel!
    
    // 인스턴스 프로퍼티니까 셀이 만들어질 때마다 color공간이 무수히 많이 생긴다 -> 한 공간을 만들어서 한 군데 저장해서 나눠서 쓸 수 있으면 좋겠다
//    let color = Color()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        travelLabel.backgroundColor = color.jackRed
        // 인스턴스를 생성하지 않고도 호출할 수 있으니까 color공간을 만들지 않아도 사용할 수 있다
        travelLabel.backgroundColor = Color.jackRed
        
        travelLabel.text = "테스트"
        travelLabel.font = .boldSystemFont(ofSize: 17)
        
        travelLabel.numberOfLines = 0
        travelLabel.backgroundColor = .clear
    }
    
    // 초기화 되는 건 사용자 입장에서 자유도가 없음 (기본값)
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .white
    }
    
    /*
    func configureBackground(row: Travel) {
        if row.like {
            self.backgroundColor = .yellow  // 꼭 필요한 상황 아니면 self도 생략
        } else {
            backgroundColor = .clear
        }
    }
    
    func configureDateLabel(row: Travel) {
        dateLabel.text = row.name
        dateLabel.backgroundColor = .clear
    }
    
    func configureTravelLabel(row: Travel) {
        travelLabel.text = row.overview
        travelLabel.numberOfLines = 0
        travelLabel.backgroundColor = .clear
    }*/
    
    // 같은 매개변수가 들어오니까 하나로 합칠 수 있음
    func configureCell(row: Travel) {
        // 100% 모든 셀의 배경에 대해서 대응
        // 사용자의 선택지에 따라 바뀌는 거면 if문
        if row.like {
            self.backgroundColor = .yellow
        } /*else {  // 없으면 왔다갔다하다보면 노란색 영역이 남아있는 상태로 다른 셀에 활용됨
            backgroundColor = .clear
        }*/
        
        dateLabel.text = row.name
        dateLabel.backgroundColor = .clear
        
        travelLabel.text = row.overview
        // 같은 디자인을 가져가는 부분은 awakeFromNib에 설정
//        travelLabel.numberOfLines = 0
//        travelLabel.backgroundColor = .clear
    }
}
