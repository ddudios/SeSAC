//
//  SearchResultViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

enum SortType: String {
    case accuracy = "&sort=sim"
    case date = "&sort=date"
    case high = "&sort=dsc"
    case low = "&sort=asc"
}

final class SearchResultViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var viewDidLoadTrigger = Observable(())
        var sortButtonTapped = Observable("")
    }
    
    struct Output {
        var title: Observable<String?> = Observable(nil)
        var total = Observable(0)
        var successData: Observable<NaverSearch> = Observable(NaverSearch(total: 0, items: []))
        var networkingFailure = Observable(())
        var recommendationDataList: Observable<[Item]> = Observable([])
        
        var sortData: Observable<NaverSearch> = Observable(NaverSearch(total: 0, items: []))
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoadTrigger.lazyBind { _ in
            self.callRequest()
        }
        
        output.title.bind { _ in }
        
        input.sortButtonTapped.bind { sort in
            self.fetchForSort(sort: sort)
        }
    }
    
    private func callRequest() {
        NetworkManager.shared.callRequest(query: output.title.data ?? "", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.output.total.data = success.total
            self.output.successData.data = success
        } failure: {
            self.output.networkingFailure.data = ()
        }
        
        NetworkManager.shared.callRequest(query: "키티", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
            self.output.recommendationDataList.data = success.items
        } failure: { }
    }
    
    private func fetchForSort(sort: String) {
        NetworkManager.shared.callRequest(query: output.title.data ?? "", sort: sort, startPosition: 1) { success in
            self.output.sortData.data = success
            print(success)
        } failure: {}
    }
}
