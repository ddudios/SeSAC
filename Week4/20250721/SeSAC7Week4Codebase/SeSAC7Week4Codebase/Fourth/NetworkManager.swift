//
//  NetworkManager.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/29/25.
//

import Foundation
import Alamofire

// Manager Vs. Service 뭔차이?

class NetworkManager {
    
    // Singleton
    // 굳이 불필요한 공간을 만들지 않고 initializer를 외부에서 생성할 수 없게 제약설정하고 나면 모든 인스턴스는 이 shared를 통해서 접근할 수 있게끔 만드는 거라
    static let shared = NetworkManager()
    private init() {}
    
    // 클로저 안에 클로저가 들어갔으니까 @escaping키워드 필요
    func callRequest(completionHandler: @escaping ([Coin]) -> Void) {
        print(#function, "첫번째")
        // 문서에서 보고 복붙
        let url = "https://api.upbit.com/v1/market/all"
        // responseString으로 서버에서 잘 뜨는지 먼저 확인 후 이 코드 사용 (최소한의 디버깅)
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: [Coin].self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                print("success", value)
                
                // 코드가 들어오더라도 실행하지 않으면 들어온 것을 실행시킬 수 없음
                completionHandler(value)
//                self.list = value  // 외부에서 value가 필요해서 매개변수로 value: [Coin] 전달
//                self.tableView.reloadData()
                
                print(value[2].korean_name)
                print(value[2].english_name)
                print(value[2].market)
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
    }
    
    func callRequestKakao(query: String, success: @escaping (KaKaoBookInfo) -> Void, fail: @escaping () -> Void) {
        print("첫번째")
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20"//&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": "KakaoAK 5eefae3d8336814cb36cbd87d26acb89"
        ]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<300).responseDecodable(of: KaKaoBookInfo.self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print("fail", error)
                fail()  // 토스트 메세지, 얼럿 (sueccess와 다른 기능이기 때문에 따로 함수를 만듦)
            }
        }
        print(#function, "세번째")
    }

}

// 굳이 왜 구분해?
    // 뷰컨 5개일 때, 모든 뷰컨에서 마켓 조회를 하고 있다면 Alamo를 5개 복붙할 것이 아니라 한곳에서
