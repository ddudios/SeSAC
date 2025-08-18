//
//  PhotoManager.swift
//  SeSACRxThreads
//
//  Created by Jack on 8/18/25.
//

import Foundation
import Alamofire
/**
 # Alamofire success / failure 의 기준은?
 - 기본적으로 .validate(statusCode: 200..<300)
 
 # 언제 fail로 넘어가나요?
 - responseDecodable을 쓸 경우 디코딩에 실패했을 때도 failure (.responseString사용시 fail X)
 */

class PhotoManager {
    
    static let shared = PhotoManager()

    private init() { }
    
    func getRandomPhoto(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   
                    
                   // error 처리 - 1. 실패일 때는 받아오는 error가 AFError여서 모든 케이스를 성공으로 만들고 전체를 옵셔널로 처리해서 해결 (200..<500)
                   
                   parameters: api.parameters,
                   // 웬만하면 성공으로 들어가게끔 200~500으로 늘림 + client_id가 들어가지 않게 parameters: api.parameters를 주석 처리
                   // 401오류가 뜨고 있는 상황일텐데, 그러면 statusCode 상으로 성공일텐데 실패로 뜨고 있다
                   // error: fail responseSerializationFailed(reason: Alamofire.AFError.ResponseSerializationFailureReason.decodingFailed(error: Swift.DecodingError.keyNotFound(CodingKeys(stringValue: "id", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"id\", intValue: nil) (\"id\").", underlyingError: nil))))
                   // 문제가 생겼을 때, 응답이 오는 JSON구조가 달라진다: 문제가 생길 수 있는 요소를 JSON구조로 알려주고 있다
                   // 성공했을 때 오는 것처럼, 실패했을 때도 JSON이 잘 온다: 성공시 json { }, 실패시 json { } 잘 알려주고 있다면 실패시의 json 키도 디코딩할 수 없나?
                   // "errors": ["OAuth error: The access token is invalid"] 유의미한 데이터가 왔으니까 에러에 들어있는 내용을 레이블로 보여주고 싶다
                   // 그런데 지금은 .responseDecodable(of: Photo.self) { response in의 Photo.self때문에 불가능하다
                   // .responseDecodable(of: Photo.self, PhotoList.self) (X): of에는 여러 개가 들어갈 수 없다
                   // 따라서 .responseDecodable은 하나의 모델에 대해서만 디코딩이 가능해서 실패했을 때에 대한 디코딩을 할 수 없다는 단점이 있다
                   
                   // 상태코드로 처리하면 되지, 굳이 키라는 것이 필요한가요?
                   // 네이버는 API요청 실패시, 400상태코드에 errorCode로 SE01이라는 다른 값들이 온다
                   // Photo는 상태코드가 잘 나뉘어있지만 네이버는 모든 오류를 400으로 주고 안쪽에 error1, 2, 3, …으로 나뉜다
                   // 그러다보면 우리는 SE01이 무슨 에러인지 알아야 하고 그 에러가 뭔지에 따라서 사용자한테 뭐가 부족한지 어떻게 해야하는지 가이드를 줄 수 있다
                   // 따라서 실패했을 때도 디코딩이 필요할 수 있다
                   
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<300)  // status code 기준으로 유효성 검증 (200~299: success) Alamofire 기준, 적지 않아도 내장되어 있음
            // 400..<500 성공으로 오고, 나머지 200번 같은 거는 실패로 왔으면 좋겠어! 라고 하면, validate에서 한번 걸러주는 작업이 필요하다
            // 성공의 범주를 키우고 싶다면, status code에 대한 케이스를 확장
            // 다른 개발자는 AF를 사용하지 않을 수도 있고, 사용하더라도 성공의 범주를 모를 수 있으니까 보통 명세해 두는 것이 좋음
        
            // 300..<500으로 설정하면 AF가 통신이 잘 되어 200번대임에도 불구하고, 유효성에 대한 설정을 잘못해서 fail이 떨어지고 있다
                // error: fail responseValidationFailed(reason: Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(code: 200))
        
        /*
        .responseString { response in  // 서버에서 응답이 잘 오는 지 확인 responseString => responseString에서 올바른 데이터가 왔는지 검증이 되면 => responseDeodable을 통해서 처리해보자
            // switch 구문을 여기서도 사용할 수 있다
            switch response.result {
            case .success(let value):  // responseDecodable은 응답을 Photo로 받으니까 성공했을 때 성공값이 Photo가 되는 반면에 responseString는 response를 String으로 받을거니까 value에 대한 값이 String으로 그대로 들어옴
                // 따라서
                dump(value)
            case .failure(let error):
                print("fail", error)
            }
            // .responseString으로 코드를 구성하면 디코딩 실패에 대한 내용은 존재할 수 없기 때문에 fail로 들어가지 않는다
            // 그래서 디코딩 실패하면 무조건 fail이 아니다, 어떤 메서드로, 응답값을 쓰냐에 따라서 다를 수 있다
        }
         */
        
        /*
        // 200~300에 해당하는 내용일 때는, 성공으로 들어갈 거니까 responseDecodable의 입장에서는 1)상태코드도 유효성이 잘 되는지 + 2)Photo까지 잘 되는지 이 2가지를 기준으로 판단해서 문제 없으면 성공으로 내려준다
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
//                errorLabel.text = value.errors
                success(value)
                
            case .failure(let error):
                print("fail", error)
            }
        }
         */
        
        /*
        // error 처리 - 2. 성공일 때와 실패일 때의 모델을 나눠서 처리 (200..<500)
        // 데이터와 상태 코드를 기준으로 성공과 실패를 나눠서 각자 다른 식판에 각각의 상태 코드에 따라서 다르게 담기게 구성
        .responseString { response in  // 식판이 없는 상태 (vs. 식판이 있는 상태: responseDecodable)
            
            // 상태 코드를 기준으로 나누기
            let code = response.response?.statusCode ?? 500  // 문제가 nil이거나 상태코드에 대해서 제대로 조회할 수 없을 때 500번으로 대체
            
            // .data가 옵셔널이라서 옵셔널 해제 구문 사용
            guard let data = response.data else { return }
            
            switch code {
            case 200..<300:  // 성공 식판 핸들링
                
                // data를 통해서 직접 디코딩할 수 있음
                do {
                    // 옵셔널이 해제된 data로부터 Photo식판에 잘 담아졌는지 확인
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    dump(result)
                } catch {
                    // 그게 아니라면 식판에 못 담은 상황
                    print("Photo 구조체에 담기 실패")
                }
                
            default:
                do {
                    // 나머지 케이스는 PhotoError에 대해서 담음
                    let result = try JSONDecoder().decode(PhotoError.self, from: data)
                    dump(result)
                } catch {
                    // 그게 아니라면 식판에 못 담은 상황
                    print("Photo 구조체에 담기 실패")
                }
            }
        }
         */
        
        /*
        // 상태 코드 기준으로 나눌 수도 있고 / JSON구조로 파악할 수도 있다
            // responseString에서 한 내용을 responseDecodable에서도 할 수 있다
        // AF 성공 기준으로 구성: 200..<300
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                // 성공했을 때(200번대+Photo잘들어옴), Photo가 그대로 담겨서 value로 찍어주면 됨
                dump(value)
                success(value)
                
                // fail을 타는 경우 1)200번대가 아닌 다른 상태코드 2)통신성공, 식판실패
            case .failure(let error):  // AFError 타입을 우리가 임의로 변경할 수 없음
                print("fail", error)
                
                // 실패했을 때만 do-try문 사용
                
                // response data도 있을 때에만 이 후 코드를 동작할 수 있게끔 구성
                guard let code = response.response?.statusCode,
                      let data = response.data else { return }
                
                do {
                    let result = try JSONDecoder().decode(PhotoError.self, from: data)
                    dump(result)
                } catch {
                    print("에러 구조체에 담기 실패. 200-299번 디코딩 실패도 이쪽으로 옴")
                }
            }
        }
         */
        
        // 상태코드를 활용한 범용적인 방법
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
                success(value)
            case .failure(let error):
                print("fail", error)
                
                // 문제있을 때는 보통 500은 클라이언트/서버에러(아예 인터넷안됨)여서 안 올 일은 없겠지만 문제가 생긴다면 500번으로 대처
                let code = response.response?.statusCode ?? 500
                
                /*
                switch code {
                // 200번대는 success로 떨어지기 때문에 고려할 필요 없음
                /*
                 case 400: print("Bad Request")  // completionHandler로 받는 형태도 가능
                 case 401: print("Unauthorizied")
                 case 403: print("Forbidden")
                 case 404: print("Not Found")
                 case 500, 503: print("Server Error")
                 default: print("Unknown Error")
                 */
                    
                // low한 Int 해결 + 지금은 메서드가 하나(getRandomPhoto)지만 여러 개인 상황까지 고려(제네릭 구조 없다는 가정 하에 여러 가지 방면으로 고려)
                    
                case NetworkError.badRequest.rawValue: print("Bad Request")  // Int보다 더 길어짐
                case NetworkError.unauthorized.rawValue: print("Unauthorizied")
                case 403: print("Forbidden")
                case 404: print("Not Found")
                case 500, 503: print("Server Error")
                default: print("Unknown Error")
                }
                     */
                    
                // rawValue를 매개변수처럼 넣을 수 있는 메서드가 있음
                // 어쩌피 상태코드는 다 Int니까, 상태코드를 rowValue에 넣어서 사용
                let errorType = NetworkError(rawValue: code) ?? .unknown
                // code는 무조건 다 Int로 값이 오지만, 만약 상태 코드에 429에러가 왔으면 NetworkError에는 429라는 에러가 없기 때문에 429를 기준으로 어떤 case에 던져줄 지 모르니까 errorType은 옵셔널 타입 -> 이는 .unknown 에러로 예외처리 지정 -> errorType이 옵셔널에서 벗어날 수 있음
                // => 더 이상 rowValue를 기준으로 판단하지 않고, 각 열거형의 케이스를 조회할 수 있게 됨
                    
                /*
                switch errorType {
                    /*
                case .badRequest: print("Bad Request")
                case .unauthorized: print("Unauthorizied")
                case .forbidden: print("Forbidden")
                case .notFound: print("Not Found")
                case .serverError, .unknown: print("Server Error")
                    
                    // 열거형이라서 default 절대 일어나지 않기 때문에 생략 가능
//                default: print("Unknown Error")
                     */
                    
                    // Error인 상황일 때 등장하는 문자열이니까 Error를 담당하는 열거형에 print 기능 넣어주기
                case .badRequest: print(errorType.userResponse)  // errorType이 가지고 있는 userResponse
                case .unauthorized: print(errorType.userResponse)
                case .forbidden: print(errorType.userResponse)
                case .notFound: print(errorType.userResponse)
                case .serverError, .unknown: print(errorType.userResponse)
                    // 각 케이스별로 내용을 조회해주는 거는 NetworkError에서 담당하고 있기 때문에, 거기에 다 요소가 있고 연산 프로퍼티에 의해서 내용을 알려주고 있기 때문에 print를 통해서 errorType에 맞는 userResponse가 나왔으면 좋겠다, 로 switch 구문도 애초에 없는 것처럼 만들 수 있다
                }
                 */
                print(errorType.userResponse)
            }
        }

    }
    
    func getRandomPhotoResponseString(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   
                    
                   // error 처리 - 1. 실패일 때는 받아오는 error가 AFError여서 모든 케이스를 성공으로 만들고 전체를 옵셔널로 처리해서 해결 (200..<500)
                   
//                   parameters: api.parameters,
                   
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<500)
        .responseString { response in  // 서버에서 응답이 잘 오는 지 확인 responseString => responseString에서 올바른 데이터가 왔는지 검증이 되면 => responseDeodable을 통해서 처리해보자
            // switch 구문을 여기서도 사용할 수 있다
            switch response.result {
            case .success(let value):  // responseDecodable은 응답을 Photo로 받으니까 성공했을 때 성공값이 Photo가 되는 반면에 responseString는 response를 String으로 받을거니까 value에 대한 값이 String으로 그대로 들어옴
                // 따라서
                dump(value)
            case .failure(let error):
                print("fail", error)
            }
            // .responseString으로 코드를 구성하면 디코딩 실패에 대한 내용은 존재할 수 없기 때문에 fail로 들어가지 않는다
            // 그래서 디코딩 실패하면 무조건 fail이 아니다, 어떤 메서드로, 응답값을 쓰냐에 따라서 다를 수 있다
        }
        
        /*
        // 200~300에 해당하는 내용일 때는, 성공으로 들어갈 거니까 responseDecodable의 입장에서는 1)상태코드도 유효성이 잘 되는지 + 2)Photo까지 잘 되는지 이 2가지를 기준으로 판단해서 문제 없으면 성공으로 내려준다
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
//                errorLabel.text = value.errors
                success(value)
                
            case .failure(let error):
                print("fail", error)
            }
        }
         */
        
        /*
        // error 처리 - 2. 성공일 때와 실패일 때의 모델을 나눠서 처리 (200..<500)
        // 데이터와 상태 코드를 기준으로 성공과 실패를 나눠서 각자 다른 식판에 각각의 상태 코드에 따라서 다르게 담기게 구성
        .responseString { response in  // 식판이 없는 상태 (vs. 식판이 있는 상태: responseDecodable)
            
            // 상태 코드를 기준으로 나누기
            let code = response.response?.statusCode ?? 500  // 문제가 nil이거나 상태코드에 대해서 제대로 조회할 수 없을 때 500번으로 대체
            
            // .data가 옵셔널이라서 옵셔널 해제 구문 사용
            guard let data = response.data else { return }
            
            switch code {
            case 200..<300:  // 성공 식판 핸들링
                
                // data를 통해서 직접 디코딩할 수 있음
                do {
                    // 옵셔널이 해제된 data로부터 Photo식판에 잘 담아졌는지 확인
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    dump(result)
                } catch {
                    // 그게 아니라면 식판에 못 담은 상황
                    print("Photo 구조체에 담기 실패")
                }
                
            default:
                do {
                    // 나머지 케이스는 PhotoError에 대해서 담음
                    let result = try JSONDecoder().decode(PhotoError.self, from: data)
                    dump(result)
                } catch {
                    // 그게 아니라면 식판에 못 담은 상황
                    print("Photo 구조체에 담기 실패")
                }
            }
        }
         */
    }
    
    func getRandomPhotoDecodable(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<300)
        
        // 상태 코드 기준으로 나눌 수도 있고 / JSON구조로 파악할 수도 있다
        // responseString에서 한 내용을 responseDecodable에서도 할 수 있다
        // AF 성공 기준으로 구성: 200..<300
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                // 성공했을 때(200번대+Photo잘들어옴), Photo가 그대로 담겨서 value로 찍어주면 됨
                dump(value)
                success(value)
                
                // fail을 타는 경우 1)200번대가 아닌 다른 상태코드 2)통신성공, 식판실패
            case .failure(let error):  // AFError 타입을 우리가 임의로 변경할 수 없음
                print("fail", error)
                
                // 실패했을 때만 do-try문 사용
                
                // response data도 있을 때에만 이 후 코드를 동작할 수 있게끔 구성
                guard let code = response.response?.statusCode,
                      let data = response.data else { return }
                
                do {
                    let result = try JSONDecoder().decode(PhotoError.self, from: data)
                    dump(result)
                } catch {
                    print("에러 구조체에 담기 실패. 200-299번 디코딩 실패도 이쪽으로 옴")
                }
            }
        }
    }
}

