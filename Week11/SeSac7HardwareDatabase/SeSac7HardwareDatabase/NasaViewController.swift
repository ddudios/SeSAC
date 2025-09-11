//
//  NasaViewController.swift
//  SeSac7HardwareDatabase
//
//  Created by Suji Jang on 9/11/25.
//

import UIKit
import SnapKit

// Delegate Vs. CompletionHandler 뭐가 장점인지 정도는 알기
// 특수한 상황이 아니면 CompletionHandler로 다 처리가 되지만, OTT서비스, 파일 관리 서비스 등에서 Delegate가 필요할 수 있음

// 고해상도 이미지
enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

class NasaViewController: UIViewController {
    
    var total: Double = 0  // 총 이미지의 크기
    var buffer = Data()  // 처음엔 빈 데이터, 타입이 Data
    let imageView = UIImageView()
    
    var session: URLSession!
    // VC에서 갖고 있어서 제어를 할 수 있도록 함
    // 데이터 있으면 옵셔널 해제 필요없음 / 데이터 없으면 nil로 앱은 터짐 (데이터 바인딩안하려고 !사용)
//    var nick: String?  // 데이터 바인딩해야함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
//        callRequest()
        callRequestDelegate()
    }
    
    // viewDidDisappear: 화면 사라질 때 호출되는 메서드
    // 화면이 사라질 때, 화면 전환할 때, 앱을 종료하거나 뷰가 사라질 때
    // 네트워크와 관련된 리소스 정리가 필요
    // ex. 다운로드 중에 뒤로가기를 누르면 받아야 할까 / 취소해야 할까 / 일시정지 해야할까
        // 이런 예외 케이스, 엣지 케이스를 얼마나 고려할 수 있을까? 공부할 때 계속 쌓고 많이 알수록 공수가 덜 틀어짐
    // ex. 카톡방에서 30장 이미지를 받는 중인데, 다른 톡방을 연다면? 다 받아야 하나, 취소해야 하나, 정지해야 하나 (기획에 따라 개발하겠지만, 이런 케이스까지는 기획자가 알기 어려움, 비즈니스적인 기획과 시스템적인 기획이 있는데 시스템적인 기획은 개발자가 먼저 얘기해서 개발적으로 고민해야 하는 부분을 정리해야 한다)
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 필요에 따라 메서드 찾아서 사용하기
        
        // 다운로드 중인 리소스도 무시하고
        // 화면이 사라진다면 네트워크 통신도 함께 중단하겠다 (다취소!)
//        URLSession().invalidateAndCancel()  // 인스턴스 메서드, 무효화시키고 취소시킴
        // 환경에 대한 리소스, default + main 요청에 대한 것을 정리하겠다
        session.invalidateAndCancel()
        
        // 다운로드가 완료가 될 때까지 기다렸다가, 다운로드가 완료되면 리소스를 정리
//        URLSession().finishTasksAndInvalidate()
        session.finishTasksAndInvalidate()
    }
    
    func callRequest() {
        print(#function)
        URLSession.shared.dataTask(with: Nasa.photo) { data, response, error in
            print("data print 시점: ", data)
            // completionHandler는 100% 완료되기 전까지는 신호를 받지 못함
            // 100% 완료가 되고 나서 단 한번만 클로저가 실행됨
            // 100mb를 10초동안 받는다는 가정하에 9.9s까지 어떤 신호도 못받음
        }.resume()
    }
    
    func callRequestDelegate() {
        print(#function)
        // 응답을 completionHandler로 받지 않겠다 -> 대신 Delegate로 빠짐
//        URLSession.shared.dataTask(with: Nasa.photo).resume()
        // 하지만 환경설정시 일반(shared/Default)/secret(Ephemeral)/Background: shared는 Delegate로 받을 수 없음
        
        // 이미지뷰에 사진을 보여줄 것이고, 문제가 생겼을 때 Alert을 띄우기 위해서 delegate로 받아오는 것들을 main환경에서 처리
//        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: Nasa.photo).resume()
        
        // session에 환경을 담아주는 과정이 필요함
        // 가지고 있어야 리소스 정리에 대한 조작이 가능
        session = URLSession(configuration: .default,
                             delegate: self,
                             delegateQueue: .main)
        session.dataTask(with: Nasa.photo).resume()
    }
}

// URLSessionDelegate를 상속받은 구체화된 protocol을 사용해야 한다
extension NasaViewController: URLSessionDataDelegate {
    
    // 1. 서버에서 최초로 응답받은 경우에 호출 (상태코드에 대한 확인)
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("111")
        dump(response)
        /**
         #header의 내용을 항상 먼저 받음: 상태코드, HTTP통신에 필요한 내용(Content-Length)을 미리 줌
         - <NSHTTPURLResponse: 0x6000002240e0> { URL: https://apod.nasa.gov/apod/image/2308/SunMonster_Wenz_960.jpg } { Status Code: 200, Headers {
             "Accept-Ranges" =     (
                 bytes
             );
             Connection =     (
                 "Keep-Alive"
             );
             "Content-Length" =     (
                 75629
             );
             "Content-Security-Policy" =     (
                 "upgrade-insecure-requests"
             );
             "Content-Type" =     (
                 "image/jpeg"
             );
             Date =     (
                 "Thu, 11 Sep 2025 01:53:13 GMT"
             );
             Etag =     (
                 "\"23a42708-1276d-6019674b4ebc0\""
             );
             "Keep-Alive" =     (
                 "timeout=5, max=100"
             );
             "Last-Modified" =     (
                 "Sat, 29 Jul 2023 01:52:55 GMT"
             );
             Server =     (
                 "WebServer/1.0"
             );
             "Strict-Transport-Security" =     (
                 "max-age=31536000; includeSubDomains"
             );
             "X-Frame-Options" =     (
                 sameorigin
             );
         } } #0
           - super: NSURLResponse
             - super: NSObject
         */
        
        // 클라 -> 요청 -> 서버 -> 응답(Header:200(data, error), Body) -> 클라
        if let response = response as? HTTPURLResponse,
           response.statusCode == 200 {
            completionHandler(.allow)  // 통신을 허락할지/말지, 이후 응답을 받겠다 (allow를 통해서 data를 받음)
            
            // 총 데이터의 양 얻기
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            print("총 데이터: ", contentLength)
            total = Double(contentLength)!
            
        } else {
            completionHandler(.cancel)  // header로 statusCode를 받았는데 그 뒤의 데이터는 받지 않겠다고 취소 처리
        }
    }
    
    // 2. 서버에서 데이터를 받아올 때마다 반복적으로 호출 (data)
        // 쓰고자 하는 데이터, 10초동안 받아온다면 10초동안 실행
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        print("222", data)
        
        // 들어오는 이미지 조각들을 다 더하면 온전한 이미지가 되기 때문에 append해줘야함: 이미지를 계속 만들어 나감
        // 이때 각각의 조각들을 패킷이라고 부른다
        // 캐싱때문에 한번 로드된 것은 바로 보일 수 있음
        buffer.append(data)
        
        // 내가 받는 이미지가 최종적으로 얼만지 알아야 얼만큼 받았는지 %로 표시할 수 있다
//        navigationItem.title = "\(buffer)"
        let result = Double(buffer.count) / total  // buffer에서 숫자만 가져오려고 count를 써줌, 그게 아니면 bytes까지 나옴
        navigationItem.title = "\(result * 100)% / 100%"
    }
    
    // 3. 오류가 발생했거나 응답이 완료가 될 때 호출 (100%)
        // 100% 완료됐을 때 신호를 nil을 통해서 주거나, 중간에 에러가 생기면 error를 던져줌
        // 이미지 조각을 다 모아서 이미지가 정상적으로 100% 완성 -> error == nil
    // 이미지뷰에 이미지를 띄우는 코드 등과 같은 코드를 작성
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: (any Error)?) {
        print("333", error)
        print(buffer)  // 총 보관이 잘 되었는지 체크
        
        imageView.image = UIImage(data: buffer)  // data 0101을 기준으로 이미지로 변환해서 이미지로 띄울 수 있는 코드를 애플이 제공
    }
}
