//
//  MovieTableViewController.swift
//  SeSACWeek2
//
//  Created by Suji Jang on 7/10/25.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet var movieTextField: UITextField!
    
    var movie = ["쥬라기공원", "어벤져스", "괴물", "겨울왕국"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movie.append("Bran")
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        /*
        print(#function)
        movie.append(movieTextField.text!)  // 데이터 추가되면
        print("됐니?")
        print(movie)
        
        // 테이블뷰도 다시 로드: 1, 2, 3을 다시 불러줘야 하는데 너무 코드가 김
        tableView.reloadData()  // ⭐️ 데이터가 달라지면 뷰도 바꿔줘야 한다
         */
        
//        if movieTextField.text?.isEmpty {}
//        if movieTextField.text != nil {  // 텍스트필드 글자가 닐인지 판단
//            if movieTextField.text!.isEmpty {  // 닐이 아니면 비어있는지 확인
//                movie.append(movieTextField.text!)
//            }
//        }
//        if movieTextField.text?.isEmpty ?? false {}
        // String? 옵셔널 스트링 타입이 맞지만,
        // 애플이 어떻게 처리하고 있냐면,
        // nil이라면 알아서 ""로 돌려주기 때문에 절대로 nil이 발생할 일이 텍스트필드에서는 없다
        // 앞에서 nil이 발생할 일이 없기 때문에 그에 대체할 ??는 필요없다
        if movieTextField.text!.isEmpty {
            print("글씨를 아무것도 안써서 추가할 수 없어요.")
        } else {
            movie.append(movieTextField.text!)
            tableView.reloadData()
        }
        
        if movieTextField.text != nil {
            print(movieTextField.text!)
        } else {
            print("nil입니다")
        }
        // 반복되는 코드, 느낌표 보기싫음, 간소화하고 싶다
        if let text = movieTextField.text {
            print(text)
        } else {
            print("nil입니다")
        }
    }
    
    
    // 1. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movie.count
    }
    
    // 2. 디자인 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        print(#function, indexPath)  // 재사용 메커니즘
        
        cell.textLabel?.text = movie[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "star.fill")
        // 조건문 쓰기 귀찮으니까, 반복되는 구문도 많으니까 ?로 줄여씀
        // nil이면 뒤의 코드를 실행하지 않고 nil이 아니면 뒤의 코드 이어서 실행
        if cell.imageView != nil {  // subTitle스타일을 쓸 때는 imageView가 없음
            cell.imageView!.image = UIImage(systemName: "star.fill")
        }
        
        // 100% 모든 셀들이 적용되도록 설정하기!
        if indexPath.row == 4 {
            cell.backgroundColor = .yellow
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    // 3. 셀 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 셀이 클릭됐을 때 실행되는 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        /*
        // 생각할 때 주의사항
        // 클릭해서 어벤져스를 없애주세요
        // 이 셀을 어떻게 지우지? (X)
        // 셀을 없애는 것이 아니라 데이터를 어떻게 없애지? (O)
        // 보이는 기준이 아닌 데이터를 기준으로 생각해야 한다
        if indexPath.row == 0 {
            movie.remove(at: 0) //데이터를 없애고
            tableView.reloadData()  // 없어진 데이터를 보여줌 (11:6)
            // 없어진 데이터는 보여줄 수 없으니까 자연스럽게 사라짐
        } else if indexPath.row == 1 {
            movie.remove(at: 1)
            tableView.reloadData()
            // 무언가를 건들 때는 데이터를 건드는 거고 화면은 단순히 보여주는 것이다 라는 사고방식
        }
         */
        
//        if indexPath.row == 0 {
//            movie.remove(at: indexPath.row)
//        } else if indexPath.row == 1 {
//            movie.remove(at: indexPath.row)
//        }
        
        movie.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
