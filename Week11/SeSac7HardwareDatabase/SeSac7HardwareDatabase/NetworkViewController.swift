//
//  NetworkViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/10/25.
//

/**
 URLSession에 대해서 잘 할 필요는 없고 한번만 만들어보면 될듯~
 - Alamofier를 쓸 수 있는 것은 내부에 URLSession으로 구성되어 있고 랩핑해서 쉽게 쓸 수 있게 만듦
 
 URLSession 이 클래스 안에 네트워크와 관련된 모든 것이 다 들어있음
 */
import UIKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
}

class NetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        callRequest()
        callLotto()
    }
    
    func callRequest() {
        /**
         # 환경설정
         각자 어떤 상황에 어떤 것을 쓸 지
         
         // 일반 shared는 보통 dataTask를 많이 사용, lottoUrl, shared이기 때문에 completionHandler밖에 사용할 수 없음
         URLSession.shared.dataTask(with: <#T##URLRequest#>) { <#Data?#>, <#URLResponse?#>, <#(any Error)?#> in
             <#code#>
         }
         
         // 위에 코드와 같은 코드
         URLSession(configuration: .default).dataTask(with: <#T##URLRequest#>)
            // configuration으로 생성하면 .default, .ephemeral, .background 3개가 나온다
            // shared는 URLSession의 싱글턴패턴으로 만들어져 있기 때문에 생성자로 만들 수 없음
         
         // 카카오톡 30장 이미지 그룹 다운로드: 30장 중에 7장 다운로드 받았다는 중간과정을 보여주고 싶음
         // - 중간과정을 보여주려면 Delegte를 사용해야 함 > 따라서 Shared는 사용할 수 없음
         // - Delegate를 사용하고 싶다면 Default(일반)/Ephemeral(secret)/Background(앱사용하지않는중에도통신) 중에 해야함
         URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            // + extension NetworkViewController: URLSession<빈거/Data/Task/Stream/Download/WebSocket>Delegate (Task에 따라서 결정)
            // delegate: tableView.delegate = self같은 거를 매개변수로 받는 형식으로 모양만 바뀜
            // delegateQueue: 보통 UI적인 업데이트를 하다보니까 .main에서 쓰겠다
         */
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150")!
        // url을 잘못 작성했을 때, 지금은 errer는 nil이고 로또API에서 상태코드를 잘 보내주지 않아서 문제가 생겨도 200으로 떨어져서 디코딩에러라고 뜨긴 함
        
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,  // 캐싱 쓸건지 말건지 정책에 관련된 내용 설정
            timeoutInterval: 5  // 언제 실패로 간주할 건지 물어보는 것임 (AF는 30초인가 60초로 해서 늦게 온것임) 5초 내로 오지 않으면 timeout처리
        )
        // 로또 API 호출
        // AF는 UI에 보여줄 때 자동으로 Main으로 전환하는 기능이 들어있음 (AF역시 내부적으로 URLSession으로 구성되어 있을 거니까 결국에는 UI에 뭘 보여주는 행위를 하려면 Main에 업데이트하는 과정이 필요할테니 AF에서는 그 기능이 내부에 들어있음
        // URLSession에서는 dataTask로 보낼 때, 네트워크 통신이니까 클로저문의 모든 내용을 Background Thread로 변경이 된다. 그러다보니까 돌아왔을 때 알아서 Main으로 돌려주는 기능은 없다. 필요에 따라서 수동으로 Main Thread로 전환해주는 코드를 작성해 주어야 한다
        URLSession.shared.dataTask(with: request) { data, response, error in
            //            print(data)
            //            print(response)
            //            print(error)
            /**
             Optional(253 bytes)  #data
             Optional(<NSHTTPURLResponse: 0x600000259b60> { URL: https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150 } { Status Code: 200, Headers {
             Connection =     (
             "keep-alive"
             );
             "Content-Length" =     (  #response에 이런 헤더가 있구나
             253
             );
             "Content-Security-Policy" =     (
             nosniff
             );
             "Content-Type" =     (
             "text/html; charset=euc-kr"
             );
             Date =     (
             "Wed, 10 Sep 2025 02:59:34 GMT"
             );
             "Set-Cookie" =     (
             "WMONID=Qsgts4Wu0dH; Expires=Thu, 10-Sep-2026 11:59:34 GMT; Path=/"
             );
             "X-Download-Options" =     (
             noopen
             );
             "X-XSS-Protection" =     (
             "1; mode=block"
             );
             } })
             nil  #error
             
             - AF에서 response를 switch success/error가 urlSession에서는 data/error
             - urlSession에서 response는 AF에서 response.response?.statusCode 의 두번째 response?프로퍼티
             */
            
            
            // Main으로 돌리는 코드가 중간에 엄청 반복되는 것이 번거롭다보니 응답을 클로저문으로 받자마자 전체 코드를 메인에서 돌리는 형태로 해결하기도 함
            DispatchQueue.main.async {
                
                if let error = error {  // error 있는지 없는지 체크
                    // 에러가 있다면 문제가 생긴 상황
//                    DispatchQueue.main.async {
                        print("오류가 발생했다.")
//                    }
                    return  // 아래 쪽은 실행되지 않도록 함수 종료시켜줘야 함
                }
                
                // 에러가 nil이면 통신이 성공했다고 볼 수 있는 상태
                guard let response = response as? HTTPURLResponse,  // nil인지 아닌지 판단
                      response.statusCode == 200 else {  // 200번대가 아니면 alert/toast
                    
//                    DispatchQueue.main.async {
                        print("상태코드 오류가 발생했다.")  // 여기가 alert이라면 MainThread가 필요함
//                    }
                    
                    return
                }
                
                // 상태코드 200인 상황: 원하는 데이터가 잘 온것이기 때문에 data를 통해서 decoder로 구조체에 내용을 꺼내줌
                if let data = data {  // data가 nil이 아닌지 확인
                    //                let result = try? JSONDecoder().decode(Lotto.self, from: data)
                    //                print(result)
                    // nil이면 디코딩 오류? 서버 통신 오류? 어떤 이슈인지 알기 어렵다 -> do-try-catch로 처리하기
                    // 모든 오류는 Nil이기 때문에 do-try-catch로 뭐가 문제인지 체크하기
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)  //JSONDecoder를 통해서 decode를 할 수 있음
                        print(result)
                        
//                        DispatchQueue.main.async {  // UI업데이트 내용만 Main Thread로 돌려줌
                            self.navigationItem.title = result.drwNoDate
//                        }
                        
                    } catch {
                        print("디코딩 오류가 발생했다.")
                        // AF에서 decodable(of:)에서 실패하는 상황
                        // do-try-catch를 잘 썼기에 뭐가 문제인지 바로 알아냄
                    }
                }
            }
        }
        .resume()  // Task 실행하라는 메서드: 없으면 네트워크 요청이 서버에 가지 않음, resume이 있어야 트리거가 돼서 요청할 수 있음
    }
    
    func callLotto() {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150")!
        
        // URLSession.shared 여기까지가 환경설정
        URLSession.shared.dataTask(with: url) { data, response, error in
            // data: JSON 형태
            // response: 상태코드
            // error: 오류
            // completionHandler: data, response, error 3개 다 옵셔널이기 때문에 옵셔널을 해제하는 과정이 필요하다
            guard error == nil else {
                print("Failed Request")
                return
            }
            
            guard let data = data else {
                print("No Data Returned")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable Response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("Status Code Error")
                return
            }
            
            print("이제 식판에 담을 수 있는 상태")
            
            do {
                let result = try JSONDecoder().decode(Lotto.self, from: data)
                print("success", result)
            } catch {
                print("error")
            }
            
        }.resume()
    }
}
