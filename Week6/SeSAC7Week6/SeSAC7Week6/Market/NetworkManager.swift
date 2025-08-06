//
//  NetworkManager.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import Foundation
import Alamofire
/*개선
 - ResultType
 - URLSession
 */

// final을 붙이면 상속이 안된다. 매서드 재정의(override)할 수 없다
// final을 붙이지 않으면, 컴파일 타임에 어떤 메서드가 실행될지 명확하게 알기는 어렵다
// final을 붙이면, 컴파일 타임에 어떤 메서드가 실행이 될지 명확하게 알 수 있다 => 런타임 상황에서 할 것들이 상대적으로 줄어든다

// final class, enum, struct => 컴파일 최적화
// 열거형, 구조체: 상속 불가능
    // 컴파일타임에 내부의 메서드가 실행되는 걸 명확하게 알기 때문에
    // 컴퓨터가 할 게 너무 많으니까 어떤 함수가 어느시점에 실행될지를 빌드해서 실제 프로덕으로 만들기 전에 이미 연결고리가 만들어져 있으면 런타임에 할 게 없어지기 때문에 최적화가 되어 성능상에 이점을 가져갈 수 있다
// 기술적인 용어 정리:
// Method Dispatch
    // 메서드가 컴파일 타임에 실행되는게 결정되는지 / 런타임 시점에 실행되는게 결정되는지
    // 컴파일에 실행: 이미 정해져있는 것이기 때문에 Static Dispatch
    // 런타임에 메서드 실행이 결정되면: Dynamic Dispatch
        // class 내부의 메서드는 항상 런타임에 결정되고 다이나믹 디스패치로 동작
        // 스태틱에 비해 상대적으로 성능이 떨어짐
        // 파이널클래스를 붙이면 파이널 내부 메서드는 스태틱 디스패치 -> 성능 최적화 달성
// 기본적으로 struct, enum 메서드 재정의될 수 없으니까 스태틱디스패치로 동작한다
enum Hello {
    
}

struct Mentor {
    
}


class Coffee {  // 부모
    func make() { }
}

class Americano: Coffee {  // 자식
    
    // make에 대한 재정의
    override func make() {  // 부모가 final이면 상속이 안되고, 메서드 재정의(override) 불가능
    }
}

// 상속받아서 처리할 게 없으면 final키워드 붙이기
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
     
    func callRequest(completionHandler: @escaping ([Coin]) -> Void) {
        
        Americano().make()  // make는 누구의 make? (super가 붙어있는지 이 코드만 보고서는 알 수 없다 - Amerocano를 직접 봐야 가능)
            // 코드를 타고 가지 않는 이상, 얼마나 부모가 많을지, make가 부모 메서드가 실행이 되는지 아닌지 알 수 없다
                // 부모 위에 부모 위에 부모 ,...
        // 컴파일 타임에서는 make라는 메서드가 어디까지 실행될지, 어떤 메서드가 실행될지 확실하게 모른다 => 런타임에 알 수 있다
        // Americano.make => super make => super make => ...
            // final을 붙이지 않으면, 컴파일 타임에 어떤 메서드가 실행될지 명확하게 알기는 어렵다
        // final 내부의 멤버는 재정의를 할 수 없다는 게 확실하다
        
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) { response in
                print(#function, "두번째")
                switch response.result {
                case .success(let value):
                    print("success", value)
                    completionHandler(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
        print(#function, "세번째")
    }
}
