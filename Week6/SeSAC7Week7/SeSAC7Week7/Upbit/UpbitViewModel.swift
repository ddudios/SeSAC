//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation
//import Alamofire

final class UpbitViewModel {
    // 화면 뜨기 직전이다 라는 생명주기 타이밍을 얻어오고 싶음
    var inputViewDidLoadTrigger: ReviewObservable<Void> = ReviewObservable(())  // Int전달조차 아까워서 빈튜플
//    var inputCellSelectedTrigger: ReviewObservable<Void> = ReviewObservable(())  // 화면 전환을 위한 트리거
    // 내용이 없을 수 있으니까 옵셔널
    var inputCellSelectedTrigger: ReviewObservable<Upbit?> = ReviewObservable(nil)  // 화면 전환 + 데이터 전달

    
    
//    var list: [String] = []  // 더미데이터
    // 변화감지 추가
//    var list: ReviewObservable<[String]> = ReviewObservable([])
    // viewController에서 사용할 list 이름 변경
//    var outputMarketData: ReviewObservable<[String]> = ReviewObservable([])
    // 모든 버그를 잡은 다음 통신 코드
    var outputMarketData: ReviewObservable<[Upbit]> = ReviewObservable([])  // 테이블뷰 데이터
    var outputNavigationTitleData = ReviewObservable("")
//    var outputCellSelected: ReviewObservable<Void> = ReviewObservable(())
    var outputCellSelected: ReviewObservable<String> = ReviewObservable("")
    
    init() {
        /**
         중복호출을 방지하기 위해서는
         - lazyBind로 개선하거나
         - bind를 쓰되 viewController viewDidLoad에서 트리거를 주지 않거나
         */
        inputViewDidLoadTrigger.bind {
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
        
        inputCellSelectedTrigger.bind {
            print("viewModel inputCellSelectedTrigger / 셀이 선택되었습니다")
            
            // 셀 선택됐으니까 output값 변경으로 다시 신호 보내줌
//            self.outputCellSelected.value = ()
            
            print(self.inputCellSelectedTrigger.value)
            self.outputCellSelected.value = self.inputCellSelectedTrigger.value?.korean_name ?? ""
        }
    }
    
    func callRequest() {
        
        // 네트워킹이 뭘하는지는 모르지만 [Upbit], String를 가져옴
        UpbitManager.shared.callRequest { market, title in
            self.outputMarketData.value = market
            self.outputNavigationTitleData.value = title
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
