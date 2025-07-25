//
//  DramaTableViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/10/25.
//

// import 순서
// - 애플 제공해주는것 먼저 -> 오픈소스
// - 이름순
import UIKit
import Kingfisher

struct Drama {  // 여러 정보를 담고 싶으니까 String 확장
    let title: String
    let date: String
    let rate: Double
    let image: String
}

class DramaTableViewController: UITableViewController {
    
//    let image: [String] = ["star.fill", "star", "heart", "heart.fill", "pencil", "xmark", "person"]
    let image: [Drama] = [
        Drama(title: "미스터션샤인", date: "2020", rate: 4.5, image: "star.fill"),
        Drama(title: "태양의후예", date: "2016", rate: 4.0, image: "star"),
        Drama(title: "도깨비", date: "2020", rate: 5.0, image: "pencil")
    ]

//    var nickname: String? = "고래밥"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 80
//        test()
    }
    /*
    // return 키워드 공부
    func test() -> String {
        let num = 4
        if num < 5 {
            print("5보다 작습니다")
            return "5보다 작습니다"
            // 함수 도중에 return키워드를 쓰면 빠르게 탈출, 여기서 종료 (early exit)
        }
        print("테스트")
        return "테스트"
    }
     */
    
    /*
    // system section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 타이틀"
    }
    
    // 섹션을 커스텀하게 설정하고 싶은 경우 (스토리보드X)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        <#code#>
    }
     */
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return image.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image.count
    }
    
    // 함수명 주의하기..~
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        print(#function)
//        return image.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath.row)
        
        // [Scene과 Logic파일 연결: 타입캐스팅] UITableViewCell타입을 -> DramaTableViewCell로 바꿔줘야 한다
        // 1. [Scene] tableView.dequeueReusableCell(withIdentifier: "dramaCell", for: indexPath) 는 스토리보드에서만 가져올 수 있다: 스토리보드에 있는 dramaCell이름을 가진 셀을 가져오는 것이라서 Scene만 가져온 것이다
        // 2. [Logic] 로직 파일도 가져와야 한다: DramaTableViewCell
        // 3. [matching] as!
        // SystemCell일 때는 안해줘도 되는데 CustomCell일 때는 해줘야 한다
        let cell = tableView.dequeueReusableCell(withIdentifier: "dramaCell", for: indexPath) as! DramaTableViewCell
        
        /*
         // 조금 덜 실행되도록 (변하지 않는)정적인 디자인은 Cell파일에서 Nib을 디자인 (할 일 줄여주기)
        cell.overviewLabel.numberOfLines = 0
        cell.overviewLabel.text = "ㅁadfasdfasdgasdgasdgasdgasdgasdgasdgasdgㅇㄹ"
        cell.posterImageView.backgroundColor = .orange
        cell.posterImageView.layer.cornerRadius = 10
        */
        
        cell.overviewLabel.text = image[indexPath.row].title
        
        let name = image[indexPath.row].image
        cell.posterImageView.image = UIImage(systemName: name)  // 애플이 제공하는 센프란시스코 심볼 띄우기
        
        // kingfisher
        // 주소 오타, 이미지 올린 사람이 내림, 서버 점검 등 이미지를 못가져올 상황을 고려해서 옵셔널로 만들어짐
        // 링크가 http
//        let url = URL(string: "http://cdn.metavv.com/prod/uploads/thumbnail/images/10043263/167100535142741_md.png")!
//        cell.posterImageView.kf.setImage(with: url)
        
        
        
        // 개발자들이 읽을 때, 특정 상황에서 바뀌는 디자인이구나라고 생각할 수 있음
        // 재사용될때 색이 남아있는 채로 셀이 출력되는데, 나머지 처리를 다 해주면 색 위에 덮어줌
        if indexPath.row == 4 {
            cell.backgroundColor = .yellow
        } /*else {
            cell.backgroundColor = .white
        }*/
        
        return cell
    }
    
    // 대신 viewDidLoad에서 tableView 속성 코드 사용할 수 있음
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function, indexPath.row)
        
        // 셀 높이를 다이나믹하게 설정 가능
        // 같은 셀을 사용하더라도 다른 셀 높이를 주고 싶을 때
        // else구문을 지우면 에러
        // 반환값이 100퍼센트 있어야 하는 상황
        // 0번 인덱스일 때만 리턴값이 있고 나머지는 리턴값이 없으면 오류
        if indexPath.row == 0 {
            return 150
        } else {
            return 80
        }
        /*
         if indexPath.row == 0 {
             return 150
         }
         return 80
         // 이러면 첫 셀은 높이가 어떻게 될까?
         // 결과적으로 동일한 코드
         */
    }
}
