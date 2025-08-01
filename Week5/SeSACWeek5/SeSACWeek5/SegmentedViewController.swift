//
//  SegmentedViewController.swift
//  SeSACWeek5
//
//  Created by Suji Jang on 8/1/25.
//

import UIKit
import SnapKit

// 열거형의 적용 범용성
// 멤버와 값의 분리 (Int, String - default값 줄 수 있음)
    // Int는 기본적으로 0부터 차례대로 rawValue를 줌, 다른 숫자를 주고 싶다면 직접 넣어주 수 있음 (ex. case statusCode = 200)
    // 앞의 case의 rawValue를 200을 넣어줬을 때, rawValue를 설정해주지 않으면 앞의 rawValue + 1
    // String 채택시, rawValue를 주지 않으면 멤버명으로 String을 줌 / 직접 rawValue를 줄 수 있음 (ex. case high = "고등학생")
enum Student: Int { //String {  // case 하나 하나를 멤버라고 한다
    case elementary  // Int채택시 String을 rawValue로 같이 줄 수는 없음
    case middle
    case high
    case university
    
    // 모든 case들이 연산프로퍼티에 접근이 가능
    var introduce: String {
        switch self {  // case가 self로 들어온다
        case .elementary:
            return "초등학생입니다"
        case .middle:
            return "중학생입니다"
        case .high:
            return "고등학생입니다"
        case .university:
            return "대학생입니다"
        }
    }
}

class SegmentedViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl()
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        print(Student.elementary)
        print(Student.elementary.rawValue)  // 아무것도 채택하지(Int, String) 않으면 rawValue 없음
        print(Student.middle)
        print(Student.middle.rawValue)
        print(Student.high)
        print(Student.high.rawValue)
        print(Student.university)
        print(Student.university.rawValue)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        segmentedControl.insertSegment(withTitle: "초등학생", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "중학생", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "고등학생", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "대학생", at: 3, animated: false)
        
        // 첫 번째 세그먼트를 기본 선택
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemGray6
        segmentedControl.selectedSegmentTintColor = .systemBlue
        
        // 레이블 설정
        resultLabel.text = "초등학생입니다"
        resultLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        resultLabel.textAlignment = .center
        resultLabel.textColor = .label
        resultLabel.backgroundColor = .systemGray6
        resultLabel.layer.cornerRadius = 12
        resultLabel.clipsToBounds = true
        
        // 뷰에 추가
        view.addSubview(segmentedControl)
        view.addSubview(resultLabel)
    }
    
    private func setupConstraints() {
        // 세그먼트 컨트롤
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 결과 레이블
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }
    
    private func setupActions() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        
        switch index {  // case는 괜찮지만 switch문은 떠리처리까지 해줘야한다 default로 예외대응
        case 0: resultLabel.text = "초등학생입니다"
        case 1: resultLabel.text = "중학생입니다"
        case 2: resultLabel.text = "고등학생입니다"
        case 3: resultLabel.text = "대학생입니다"
        default: resultLabel.text = "대학생입니다"
        }
        
        // default를 사용하지 않으려면?
        var student: Student = .elementary  // Student 안의 4개 중에서만 사용할 수 있음
        // 열거형을 굳이 왜 배워야하지? 그동안 잘 사용중 - 실수하지 않게
        /*
        resultLabel.textAlignment = .center
        public enum NSTextAlignment : Int, @unchecked Sendable {

            case left = 0

            case center = 1

            case right = 2

            case justified = 3

            case natural = 4
        }
         
        UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: .alert)
        */
        
        
        // 1. default없이 사용할 수 있다
        // 2. 코드의 의도를 알아보기 쉽다
        // 3. 같은 그룹군임을 명세
        // 만약 일본어로 값이 써있다면? 1, 2, 3이 뭔지 몰라도 .elementry 등을 보면 코드를 유추할 수 있다
        switch student {  // 지금 뜨는 경고는 버전 이슈
        case .elementary: resultLabel.text = "초등학생입니다"
        case .middle: resultLabel.text = "중학생입니다"
        case .high: resultLabel.text = "고등학생입니다"
        case .university: resultLabel.text = "대학생입니다"
        }
        
        if index == 0 {
            resultLabel.text = "초등학생입니다"
        } else if index == 1 {
            resultLabel.text = "중학생입니다"
        } else if index == 2 {
            resultLabel.text = "고등학생입니다"
        } else if index == 3 {
            resultLabel.text = "대학생입니다"
        }
        
        // Student에는 없는 100번 같은게 들어갈 수 있어서 result는 옵셔널 타입
        let result = Student(rawValue: index) ?? .university
        switch result {
        case .elementary: resultLabel.text = "초등학생입니다"
        case .middle: resultLabel.text = "중학생입니다"
        case .high: resultLabel.text = "고등학생입니다"
        case .university: resultLabel.text = "대학생입니다"
        }
        
        switch result {
        case .elementary: resultLabel.text = result.introduce  // case의 연산프로퍼티 호출
        case .middle: resultLabel.text = result.introduce
        case .high: resultLabel.text = result.introduce
        case .university: resultLabel.text = result.introduce
        }
        
        resultLabel.text = result.introduce
        
        // case 사용시 유의점
        // Int rawValue를 같은 값으로 쓸 수 있을까?
            // 고유값이기 때문에 각각의 케이스가 같은 내용을 가질 수 없다
        enum Resource: String {
            case button = "저장"  // 얼럿 버튼명 저장, 바버튼명 저장 -> rawValue는 고유값이기 때문에 동일한 내용이라면 케이스로 나눌 수 없다 -> struct 사용 (let사용 못함, 케이스로 나눌 수 없음) / static let
//            case alertButton = "저장"
            case cancel = "취소"
            
            static let barCancel = "취소"
            static let alertCancel = "취소"
        }
        
        // Nested Enum -> case의 수를 적게 가져갈 수 있음
        enum Constant {
            
            enum Color {
                case TextColor
                case bgColor
            }
            
            enum Text {
                enum Style {
                    case textTitle
                }
            }
        }
    }
}
