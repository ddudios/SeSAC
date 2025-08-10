//
//  DecodableViewController.swift
//  SeSAC7Week6
//
//  Created by Suji Jang on 8/7/25.
//

import UIKit

struct Movie: Decodable {
    let movieTitle: String
    let likeCount: Int
    let director: String//String?  // nil포함 가능 -> nil상황을 계속 대처해야한다 (서버에선 null일지라도 내 코드에서는 String으로 받고싶다)
    let isTopRank: Bool  // 서버에는 없는 데이터 가공
    
    // 식판 이름 재구성
    /*
    enum CodingKeys: String, CodingKey {  // 매칭
        case movie = "movie_title"  // 외부 데이터와 연결지어서 짝꿍을 맞춰줌
        case likeCount
        case director
    }
     */
    
    enum CodingKeys: String, CodingKey {
        case movieTitle = "movie_title"  // 맵핑
        case likeCount
        case director
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 컨테이너를 통해서 키에 키가 있는지 물어보고 있으면 담아줌
        self.movieTitle = try container.decode(String.self, forKey: .movieTitle)
        self.likeCount = try container.decode(Int.self, forKey: .likeCount)
//        self.director = try container.decode(String.self, forKey: .director)  // 무조건 들어있다고
        // 등호를 기준으로 왼쪽: 우리가 사용하는 거라서 nil들어가지만 // 오른쪽은 서버에서 들어오는 건데 무조건 값이 있다고 되어 있다
        self.director = try container.decodeIfPresent(String.self, forKey: .director) ?? "서버 이슈 발생"
        // 서버에서 넘어오는 키가 변경된다는 가정, 테그가없더라도 앱이 터지지 않게, 앱이 실행은 되도록 이 부분을 많이 사용하면 좋다
        
        // 서버에서 제공한 것처럼 데이터를 가공해서 담을 수 있음
        // 10000이상에 해당하는 값이 있다면 true / 없으면 false
        self.isTopRank = (10000...).contains(likeCount) ? true : false
    }
}

/*
 1. 디코딩을 할 때, 키값이 다르다면 디코딩이 실패한다 (catch)
 2. 옵셔널로 해결하기 -> 런타임이슈X, 식판을 못찾았으니까 nil
    but 원하는 값을 담을 수 없음
 3. 디코딩 전략
    1. CodingKey를 활용하기: 원하는 키랑 외부 데이터 매칭
    2. snakecase를 활용하기: keyDecodingStrategy / keyEncodingStrategy
    3. init으로 ㅐ결하기: decode / decodeIfPresent
 */

class DecodableViewController: UIViewController {
    
    let movie = """
                {
                    "movie_title": "좀비딸", 
                    "likeCount": 12345,
                    "director": null
                }
                """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //response > decodable >
        
        // ResponseDecodable이 하는 작업
        // data로 바꿔주는 작업 (01010) 옵셔널이기때문에 guard문 활용
        // String -> Data
        guard let data = movie.data(using: .utf8) else {
            print("실패")
            return
        }
        
        /*
         //2.
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy  // 날짜 표기 방식 다르게 담기
        decoder.keyDecodingStrategy = .convertFromSnakeCase  // snakecase -> camelcase
        
        // Data -> Struct
        do {
            // decode통해서 식판에 담음(타입 지칭, 외부에서 온 데이터를)
            let value = try decoder.decode(Movie.self, from: data)
            dump(value)
        } catch {
            // 못담으면 catch
            print(error)  // 선언한적없지만 애플에서 내부적으로 catch에 만들어 놓음
        }*/
        
        //3.
        
        // 조건문 대신 디코딩으로 해결하는 방법
//        if derector == nil {
//            label.text = "감독없음"
//        }
        
        let decoder = JSONDecoder()
        
        // Data -> Struct
        do {
            // decode통해서 식판에 담음(타입 지칭, 외부에서 온 데이터를)
            let value = try decoder.decode(Movie.self, from: data)
            dump(value)
        } catch {
            // 못담으면 catch
            print(error)  // 선언한적없지만 애플에서 내부적으로 catch에 만들어 놓음
        }
    }
}
