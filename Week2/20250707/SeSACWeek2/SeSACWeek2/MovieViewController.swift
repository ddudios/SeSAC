//
//  MovieViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/8/25.
//

import UIKit

// 나만의 String: 타입이 부족해서 나만의 타입을 만듦
struct Movie {
    let title: String
    let open: String
    let runtime: Int
}

class MovieViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var movieLabel: UILabel!
    
    // 항상 극단적으로 생각하기: 3천개 있다 -> 어떤 문제가 생길까?
    // 필요한 정보들을 묶어서 관리하고 싶다
//    let list: [String] = ["어벤져스", "엑스맨", "좀비", "가족"]
//    let openDate = ["2025", "2018", "2020", "2023"]
//    let runtime = [134, 76, 100, 120]
    // init구문 사용하지 않았지만 -> 멤버와이즈 이니셜라이저
    let list: [Movie] = [
        Movie(title: "어벤져스", open: "2025", runtime: 134),
        Movie(title: "쥬라기", open: "2018", runtime: 120),
        Movie(title: "라이프", open: "2015", runtime: 130)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Date() Struct - 이니셜라이저 만듦, 초기화함
        print(Date())  // current time. 영국 표준시 기준
        
        // 1. 국가마다 시간이 다른 걸 맞춰주어야 함
        // 2. 사용자 입장에서 날짜를 표현하기
        let format = DateFormatter()
        
        // 모든 국가에 년도 월 일 시 분은 있기 때문에 만들어져 있음 (2)
        format.dateFormat = "YY M/d EEEE"
        // 해외 주번호 YYYY: 각각의 Week를 주번호
            // 주번호를 기준으로 신년을 측정 20251231
            // 해가 넘어가는 걸쳐있는 마지막 주/첫 주에 오류가 생길 수 있음
        // yyyy 20241231
        
        // 시간을 넣어주면 위의 폼으로 사용자의 국가 시간에 맞춰서 자동으로 표현 (1)
        let result = format.string(from: Date())
        
        let component = DateComponents()
//        component.year = 2025  // error: let -> var (구조체이기 때문)
        
        dateLabel.text = result
        
        let number = Int.random(in: 0...list.count - 1)
//        movieLabel.text = "\(list[number]), \(openDate[number]), \(runtime[number])"
        movieLabel.text = "\(list[number].title)"
        
        // 인스턴스 프로퍼티
        movieLabel.text = "a"
        print(movieLabel)
    }
}
