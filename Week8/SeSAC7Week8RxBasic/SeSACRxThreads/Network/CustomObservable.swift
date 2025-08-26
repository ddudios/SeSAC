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
    
    static func testCompletionHandler(
        query: String,
        success: @escaping ((Lotto) -> Void),
        failure: @escaping (() -> Void)
    ) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                success(value)
            case .failure(let error):
                print(error)
                failure()
            }
        }
    }
    // 굳이 매개변수만 많이 차지하는 것 같아서 하나의 메서드로 성공,실패 실행시킬 수 없나?
    static func testCompletionHandlerResult(
        query: String,
        completionHandler: @escaping ((Lotto?, AFError?) -> Void)
    ) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    // 위 방식은 Result타입 이전
        // 논리적으로 경우의 수를 볼 때, 둘 다 옵셔널이니까 O O, O X, X O, X X 안될 줄은 알지만, 가능 (O O, X X는 버려짐)
        // Lotto?, Error?, Status?
        // O X X, X O X, X X O (5개의 케이스가 버려짐)
    static func testCompletionHandlerResult(
        query: String,
        completionHandler: @escaping ((Result<Lotto, AFError>) -> Void)  // Result: 무조건 둘 중 하나만 들어갈 수 있는 타입
        // 열거형이라서 둘 중 하나만 등장
    ) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(.success(value))
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
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
                    print(error)
//                    observer.onError(JackError.invalid)
                    // 에러핸들링 (3) (실제 많이 쓰는 방법): 에러를 보내지말아야겠다 -> 그럼 에러를 받지 않으니까 끊기지 않음 (에러를 받으니까 자식 에러 받고 -> 부모 에러 -> 스트림 끊김)
                    observer.onNext(Lotto(drwNoDate: "오류", firstAccumamnt: 0))
                }
            }
            return Disposables.create()  // create클로저에 대한 return
        }
    }
    
    // Result타입으로 확장
    static func getResultLotto(query: String) -> Observable<Result<Lotto, JackError>> {
        return Observable<Result<Lotto, JackError>>.create { observer in
            
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                    
                case .success(let value):
                    
                    observer.onNext(.success(value))
                    observer.onCompleted()
                    
                case .failure(let error):
                    
                    // next이벤트이긴 한데 실패를 안에 숨겨서 넘김
                    observer.onNext(.failure(.invalid))
                    observer.onCompleted()  // next니까 누수 생기지 않게 onCompleted까지!!!
                }
            }
            return Disposables.create()  // create클로저에 대한 return
        }
    }
    
    // Single로 바꾸니까 안에 Result이벤트가 숨어있음
    static func getLottoWithSingle(query: String) -> Single<Result<Lotto, JackError>> {
        return Single.create { observer in
            
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                    
                case .success(let value):
                    print(value)
                    // onNext
                    // onCompleted
                    observer(.success(.success(value)))
                    // 담아서 observer(여기에 담아서 보냄)
                    
                case .failure(let error):
                    print(error)
                    // onError
                    observer(.success(.failure(.invalid)))
                    // onComplete은 success에만 들어있음
                }
            }
            return Disposables.create()
        }
    }
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstAccumamnt: Int
}
