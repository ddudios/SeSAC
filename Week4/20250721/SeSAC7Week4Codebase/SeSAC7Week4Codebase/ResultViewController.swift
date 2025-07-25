//
//  ResultViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/21/25.
//

import UIKit
import SnapKit
/*
 스토리보드의 아웃렛 대신
 1. 객체(레이블 등 클래스의 인스턴스)를 얹음
 2. 배치
 3. 아웃렛
 */

class ResultViewController: UIViewController {
    
    // ResultViewController도 클래스이기 때문에 init(){}이 숨어있다
        // 하지만 이 클래스는 단순한 클래스와 달리 :UIViewController로 상속받고 있어서 여러 초기화구문을 추가해줘야 한다
//    init() {}
    
    
//    @IBOutlet var resultLabel: UILabel!
    let resultLabel = UILabel()  // 인스턴스화 시키는 것: 아웃렛 대신 레이블 만듦, 인스턴스를 생성해서 resultLabel에 담음
        // 담았기만 해서 아직 뷰에 안올라와있음: 객체를 얹어야 배치를 할 수 있음
    let redView = UIView()  // UIView는 객체를 포함시킬 수 있다
    let blackView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스토리보드에서 가져올 수 있는 기본 정보가 아무것도 없음
            // 스토리보드는 흰색 백그라운드가 기본으로 깔려있었는데 배경색이 지정되어있지 않아서 뜨고는 있는데 안뜨는 것처럼 보임
        view.backgroundColor = .white
        
        // 방법3. SnapKit
        view.addSubview(resultLabel)
        
        // snp: 스냅킷 프로퍼티
        // 코드가 직관적, 간결해서 사용 -> 내부에서 LayoutConstraints로 바꿔줌
        // make가 오토레이아웃을 잡는 하나하나가 될 것이다
        /*
        resultLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }*/
        
        // 공통적인 코드 -> 합쳐서 사용 가능
        resultLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(view).offset(20)
            // offset은 계속 +: trailing, bottom은 -를 사용해서 역으로 올려줌
                // 이를 방지하기 위해서 inset의 개념이 있다: 기준점을 기준으로 안쪽으로 들어감
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.backgroundColor = .systemGreen
        
        view.addSubview(redView)
        redView.addSubview(blackView)
        
        redView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.width.height.equalTo(100)  // .width.height == .size
//            make.height.equalTo(100)
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
        }
        redView.backgroundColor = .red
        
        /*
        blackView.snp.makeConstraints { make in
//            make.leading.equalTo(view).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            // Superview는 어떻게 계층을 설정했냐에 따라서 기준이 달라진다: 지금 blackView의 Superview는 view
            // .leading.trailing == .horizontalEdges 수평엣지
            // .top.bottom == .verticalEdges 수직엣지
            make.top.equalTo(redView.snp.bottom).offset(50)
            make.bottom.equalTo(view).offset(-50)
        }*/
        
        // redView와 똑같이 만들기 - 레이아웃을 동일하게 가져가서 사용하기: 이렇게 redView의 레이아웃이 먼저 잡혀있어야 blackView도 잡을 수 있다
        // 애플이 뷰를 만드는 특성이 상대적인 것
        blackView.snp.makeConstraints { make in
//            make.leading.equalTo(redView.snp.leading)
//            make.trailing.equalTo(redView.snp.trailing)
//            make.top.equalTo(redView.snp.top)
//            make.bottom.equalTo(redView.snp.bottom)
            
            // 두 줄로 줄이기
//            make.horizontalEdges.equalTo(redView.snp.horizontalEdges)
//            make.verticalEdges.equalTo(redView.snp.verticalEdges)
            
            // 한 줄로 줄이기
            make.edges.equalTo(redView).inset(20)
        }
        
        blackView.backgroundColor = .black
    }
    
    // 방법1. Frame 기준으로 오토레이아웃 잡는 방식
    func practiceFrameBasedLayout() {
        // 객체 추가
        view.addSubview(resultLabel)  // 객체를 바탕view에 얹음: view를 기준으로 왼쪽 위가 0점으로 위치를 잡음
        
        view.addSubview(blackView)  // 겹쳐서 밑에 있는 것은 addSubview 순서: 이 순서면 redView만 보임
//        view.addSubview(redView)
//        resultLabel.addSubview(redView)  // 뷰 구조상, 레이블 안에 뷰를 넣을 수 없다, 거의 UIView안에만 넣음
        
        // 같은 선상에 있는 것이 아닌 포함 관계를 만들고 싶다면, 누구 안에 들어갈 지 먼저 적고 넣을 것을 넣음
        blackView.addSubview(redView)  // 프레임(상대적인 기준) 위치는 동일한데 blackView기준으로 redView를 그림
        
        // 객체 배치
        // frame: CGRect는 네모를 어떻게 뭐? (11:00 놓침, 캡쳐, 11:6)
        resultLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        redView.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
        blackView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        
        // 객체 속성 설정: 스토리보드에 할 때 기본적으로 지원해 주던 것을 하나하나 다 넣어주어야 한다
        resultLabel.backgroundColor = .gray
        resultLabel.text = "레이블 텍스트"
        redView.backgroundColor = .red
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 20
        blackView.clipsToBounds = true  // 나 영역 외에 잘라서 버림
    }
    
    // 방법2. 레이아웃으로 잡는 방법(방정식): 높이가 달라질 때
    func practiceAutolayout() {
        // 제약조건이 방정식으로 정리되어 있다
        view.addSubview(resultLabel)
        
        // Autoresizing 기능 사용하지 않겠다 (스냅킷에는 내장되어 있음)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false  // 되어 있어야 레이아웃이 적용된다
        // 적지 않으면 기본값이 true (로 설정되어 있으면 코드에 대한 적용이 전혀 되지 않는다) -> 적용되지 않아서 잊지 않고 하나하나 설정해줘야함
        // 스토리보드에서 레이아웃을 잡지 않았을 때도 실행하면 왼쪽 상단에서 차례대로 채워진다
            // 이는 Autoresizing기능이 기본으로 들어있어서 (왼쪽과 위쪽에 고정으로 설정되어 있음) 어느정도 배치가 된다
            // 어느정도 배치가 되기 때문에 Autoresizing과 AutoLayout이 호환돼 동시에 사용할 수 없음
            // 기본적으로는 Autoresizing기능이 켜져있음 AutoLayout을 하나라도 잡으면 Constraints(=AutoLayout)로 바뀐다
            // 스토리보드에서 자동으로 Autoresizing기능이 꺼지고, Constraints를 켜주는 기능이 있다
                // == 스토리보드에서는 resultLabel.translatesAutoresizingMaskIntoConstraints를 false로 바꿔주는 기능이 내재돼있음
                // 따라서 스토리보드에서는 이 코드를 신경쓸 일이 없었는데, 코드베이스는 자동으로 안해주기 때문에 Autoresizing기능을 끄는 코드를 추가해줘야 한다
        
        // 스토리보드에서 설정하는 레이아웃: NSLayoutConstraint 클래스 사용 (최소 버전 iOS 6+)
        /*
        // 위20 왼오20 높이44
        let leading = NSLayoutConstraint(item: resultLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        // item: 누구 레이아웃 잡을지 (지정할 객체)
        // toItem: 누구 대상으로 레이아웃 잡을지 (비교대상)
        // attribute: 레이아웃 잡기
            // resultLabel의 리딩과 view의 리딩을 같게
        // multiplier: 안쓰면 1로 놓음
        // 너무 길어서 leading에 담아줌 또는 끝에 .isActive = true
        leading.isActive = true
        
        NSLayoutConstraint(item: resultLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true

        NSLayoutConstraint(item: resultLabel, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20).isActive = true

        NSLayoutConstraint(item: resultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44).isActive = true  // 높이는 비교대상이 없기 때문에 nil
        
        // 좀 더 편리하게 쓸 수 없을까?
        let trailing = NSLayoutConstraint(item: resultLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        let bottom = NSLayoutConstraint(item: resultLabel, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20)
        
        let height = NSLayoutConstraint(item: resultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44)
        view.addConstraints([leading, trailing, bottom, height])  // 코드가 길기도하고, isActive를 모든 상태에 적용해줘야 하는 불편함 때문에 묶어서 사용
        */
        
        // 이래도 불편하기 때문에 간결하게 쓸 수 있는 NSLayoutAnchor 클래스 등장(iOS 8+)
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resultLabel.heightAnchor.constraint(equalToConstant: 44),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        resultLabel.backgroundColor = .systemGreen
    }
}
