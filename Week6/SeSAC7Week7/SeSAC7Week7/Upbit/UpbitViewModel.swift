//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation
//import Alamofire

final class UpbitViewModel {
    
    // viewModel이 사용할 수 있는 프로퍼티를 2개로 제약
    // - 뷰모델의 형태를 모두 유사하게 만들어가는 중
    var input: Input
    var output: Output
    
    struct Input {
        // 화면 뜨기 직전이다 라는 생명주기 타이밍을 얻어오고 싶음
        var viewDidLoadTrigger: ReviewObservable<Void> = ReviewObservable(())  // Int전달조차 아까워서 빈튜플
    //    var inputCellSelectedTrigger: ReviewObservable<Void> = ReviewObservable(())  // 화면 전환을 위한 트리거
        // 내용이 없을 수 있으니까 옵셔널
        var cellSelected: ReviewObservable<Upbit?> = ReviewObservable(nil)  // 화면 전환 + 데이터 전달
        
    }
    
    struct Output {
        //    var list: [String] = []  // 더미데이터
            // 변화감지 추가
        //    var list: ReviewObservable<[String]> = ReviewObservable([])
            // viewController에서 사용할 list 이름 변경
        //    var outputMarketData: ReviewObservable<[String]> = ReviewObservable([])
            // 모든 버그를 잡은 다음 통신 코드
            var marketData: ReviewObservable<[Upbit]> = ReviewObservable([])  // 테이블뷰 데이터
            var navigationTitleData = ReviewObservable("")
        //    var outputCellSelected: ReviewObservable<Void> = ReviewObservable(())
            var cellSelected: ReviewObservable<String> = ReviewObservable("")
    }

    init() {
        input = Input()
        output = Output()
        
        /**
         중복호출을 방지하기 위해서는
         - lazyBind로 개선하거나
         - bind를 쓰되 viewController viewDidLoad에서 트리거를 주지 않거나
         */
        input.viewDidLoadTrigger.lazyBind {
            print("viewModel inputViewDidLoadTrigger / ViewDidLoad 시점")
            
//            self.list.value = ["j", "k", "h", "s", "8"]
//            self.outputMarketData.value = ["j", "k", "h", "s", "8"]
            self.callRequest()
        }
        
//        list.bind {  // list가 변경되면 하고싶은 일
//            // 빈배열에서 list가 변경되니까 print됨
//            print("list 변경", self.list.value)
//        }
        
//        outputMarketData.bind {
//            print("outputMarketData 달라짐")
//            print(self.outputMarketData.value)
//        }
        
        input.cellSelected.bind {
            print("viewModel inputCellSelectedTrigger / 셀이 선택되었습니다")
            
            // 셀 선택됐으니까 output값 변경으로 다시 신호 보내줌
//            self.outputCellSelected.value = ()
            
            print(self.input.cellSelected.value)
            self.output.cellSelected.value = self.input.cellSelected.value?.korean_name ?? ""
        }
    }
    
    /**
     # viewController와 viewModel의 bind마다 print를 찍어보면, 호출이 얼마나 많이 되는지, 어떤 문제가 생기는지 볼 수 있다
     ## bind의 역할은 즉시 실행하면서 담겠다
     Observable Init
     Observable Init
     Observable Init
     Observable Init
     Observable Init
     Observabe Bind
     viewModel inputViewDidLoadTrigger / ViewDidLoad 시점
     callRequest(completionHandler:)
     Observabe Bind
     viewModel inputCellSelectedTrigger / 셀이 선택되었습니다
     nil
     Observable didSet
     Observable didSet
     viewModel inputViewDidLoadTrigger / ViewDidLoad 시점
     callRequest(completionHandler:)
     Observabe Bind
     viewController outputMarketData / list 변경
     Observabe Bind
     viewController outputNavigationTitleData
     Observabe Bind
     viewController outputCellSelected / output
     Observable didSet
     viewController outputMarketData / list 변경
     Observable didSet
     viewController outputNavigationTitleData
     Observable didSet
     viewController outputMarketData / list 변경
     Observable didSet
     viewController outputNavigationTitleData
     nw_protocol_socket_set_no_wake_from_sleep [C1.1.1:3] setsockopt SO_NOWAKEFROMSLEEP failed [22: Invalid argument]
     nw_protocol_socket_set_no_wake_from_sleep setsockopt SO_NOWAKEFROMSLEEP failed [22: Invalid argument]
     nw_protocol_socket_set_no_wake_from_sleep [C1.1.1:3] setsockopt SO_NOWAKEFROMSLEEP failed [22: Invalid argument]
     nw_protocol_socket_set_no_wake_from_sleep setsockopt SO_NOWAKEFROMSLEEP failed [22: Invalid argument]
     */
    
    func callRequest() {
        
        // 네트워킹이 뭘하는지는 모르지만 [Upbit], String를 가져옴
        UpbitManager.shared.callRequest { market, title in
            self.output.marketData.value = market
            self.output.navigationTitleData.value = title
        }
        
        /*
        print(#function)
        let url = "https://api.upbit.com/v1/market/all"
        
        // 1. 일단 네트워크 통신이 잘 되는지 확인
//        AF.request(url).responseString { data in
//            print(data)
//        }
        
        // responseDecodable: 구조체에 담는 과정
        AF.request(url).responseDecodable(of: [Upbit].self) { response in
            switch response.result {
            case .success(let value):
//                print(value)
                // 디버깅 순서를 잊지 말아야 한다
                
                // 그동안 하던거
//                self.list = value
//                self.tableView.reloadData()
                // 뷰에 잘 보이는지 확인부터
//                self.outputMarketData.value = ["1", "2", "3"]
                self.outputMarketData.value = value
                
                let random = value.randomElement()?.korean_name
                self.outputNavigationTitleData.value = random ?? ""
                
            case .failure(let error):
                print(error)
            }
        }
         */
    }
}
