//
//  SearchResultViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

final class SearchResultViewModel {
    
    var inputViewDidLoadTrigger = Observable(())
    
    var outputTitle: Observable<String?> = Observable(nil)
    var outputTotal = Observable(0)
    var outputSuccessData: Observable<NaverSearch> = Observable(NaverSearch(total: 0, items: []))
    var outputNetworkingFailure = Observable(())
    var outputRecommendationDataList: Observable<[Item]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.lazyBind { _ in
            self.callRequest()
        }
        
        outputTitle.bind { _ in }
    }
    
    func callRequest() {
        NetworkManager.shared.callRequest(query: outputTitle.data ?? "", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.outputTotal.data = success.total
            self.outputSuccessData.data = success
        } failure: {
            self.outputNetworkingFailure.data = ()
        }
        
        NetworkManager.shared.callRequest(query: "키티", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.outputRecommendationDataList.data = success.items
        } failure: { }
    }
}
