//
//  LottoViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/24/25.
//

import UIKit
import Alamofire

class LottoViewController: UIViewController {
    
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        resultLabel.backgroundColor = .yellow
        resultLabel.text = "테스트"
        
        callRequest()
    }
    
    func callRequest() {  // Alamofire를 통해서 API 받아옴
        print(#function)
        // AlamoFire =상수로부터 request메서드 호출해오겠다
            // url링크를 통해서 가져와달라고 요청
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1181"
            // 잘못될 수 있는 모든 상황에 대해서 알아야 한다: 모든걸 의심하기
            // 1181회차 -> 아무 회차도 쓰지 않음 -> returnValue: fail
            // 애초에 잘못된 링크 -> 접근조차 안되는 url (error: 요청 자체를 실패)
//        let url = "https://api.upbit.com/v1/market/all"
        /*
        AF.request(url, method: .get).responseString { response in  // 알라모파이어에서 정해논 형태
            print("response start")
            print(response)
            print("response end")
        }
        // response(어떤 방식으로 응답받을지 선택)
            // 기본적으로 0101 responseData
            // 우리가 알아볼 수 있는 내용 responseString
        print("callRequest end")*/
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Lotto.self) { response in
//            print(response)
            switch response.result {
            case .success(let value):
                print("success", value)
                // 식판에 잘 담긴 경우 value로 구조체 자체를 받아올 수 있음
                self.resultLabel.text = value.drwNoDate
                    // 꼭필요한 상황이 아니면 self 생략
                        // 중괄호 안에서 사용 또는
                        // 알라모파이어 다른 개발자가 만든 블럭 안에서 알라모파이어에서 resultLabel을 쓰고 있으면 어떡함? 명확히 나의 레이블이다라고 표시
            case .failure(let error):  // wifi(X)
                print("fail", error)
            }
        }
        // AF 깃헙에 어떤 형태로 사용하라고 나와있고 복사해서 사용
        // of: 어떤 식판에 담을지 (Lotto식판 그 자체에 담겠다)
    }
}
