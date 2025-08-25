//
//  CustomObservable.swift
//  SeSACRxThreads
//
//  Created by Suji Jang on 8/25/25.
//

import Foundation
import RxSwift
import Alamofire

/**
 #사용하는 이유: 여러 연산자들을 줄일 수 있는 형태
 .map.map.map.map ... -> .jackMap
 */
final class CustomObservable {
    static func randomNumber() -> Observable<Int> {  // 굳이 Rx로 만들어보기 (Swift코드 숨겨보기)
//        Observable.just("dfadf")  // Observable<String>
//        CustomObservable.randomNumber()  // Observable<Int> just 대신 custom사용
        return Observable<Int>.create { observer in  // return Observable<Int>를 만들어줘!
            
            observer.onNext(Int.random(in: 1...100))
            observer.onCompleted()  // 이거 완전중요: 메모리 누수 해결
            
            return Disposables.create()
            // static func create(_ subscribe: @escaping (AnyObserver<Int>) -> any Disposable) -> Observable<Int>
        }
        // just: 단순히 데이터 통으로 보내줌
        // create: 직접 우리가 무언가 만들 수 있게 도와줌
    }
    
    static func recommandNickname() -> Observable<String> {
//        .map {
//            let a = []
//            a.randomElement()
//        }  // 굳이 Rx로 만들어보기 (Swift코드 숨겨보기)
        return Observable<String>.create { observer in  // Observable에 해당하는 연산자를 만들어주겠다
            
            // 어떤 기능을 할 지 구현
            let text: [String?] = ["고래밥", nil, "칙촉", "몽쉘", "오예스", "카스타드"]
            
            // 랜덤으로 뽑았을 때 nil을 만나거나 카스타드를 만나면 오류가 발생한다고 가정
            guard let random = text.randomElement(),
                  let result = random else {
                observer.onError(JackError.invalid)
                return Disposables.create()
            }
            
            if result == "카스타드" {
              observer.onError(JackError.invalid)
            } else {
                
                // 클로저를 통해서 결과값을 next이벤트로 전달
                observer.onNext(result)
                
                // 더이상 리소스를 쓸 일이 없을 때 리소스 정리해달라고 요청
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    static func getLotto(query: String) -> Observable<Lotto> {  // Lotto응답값을 받을 수 있는 Observable
        return Observable<Lotto>.create { observer in  // getLotto함수에 대한 리턴값:Observable<Lotto>
            
            // 원하는 기능 작성
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    
//                    print(value)
//                    completionHandler(value.drwNoDate)
                    observer.onNext(value)
                    observer.onCompleted()  // 이를 통해 리소스를 정리할 수 있게 만들어야한다
                    
                case .failure(let error):
//                    print(error)
                    observer.onError(JackError.invalid)
                }
            }
            return Disposables.create()  // create클로저에 대한 return
        }
    }
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstAccumamnt: Int
}
