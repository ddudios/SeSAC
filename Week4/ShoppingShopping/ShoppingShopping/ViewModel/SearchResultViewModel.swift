//
//  SearchResultViewModel.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

enum SortType: String {
//    case accuracy = "&sort=sim"
//    case date = "&sort=date"
//    case high = "&sort=dsc"
//    case low = "&sort=asc"
    case accuracy = "sim"
    case date = "date"
    case high = "dsc"
    case low = "asc"
}

final class SearchResultViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
//        var viewDidLoadTrigger = Observable(())
        var sortButtonTapped = SwiftCustomObservable("")
        var reload = SwiftCustomObservable(())
        var sortType = SwiftCustomObservable(SortType.accuracy.rawValue)
        var startPage = SwiftCustomObservable(1)
    }
    
    struct Output {
        var title: SwiftCustomObservable<String?> = SwiftCustomObservable(nil)
        var total = SwiftCustomObservable(0)
        var successData: SwiftCustomObservable<NaverSearch> = SwiftCustomObservable(NaverSearch(total: 0, items: []))
        var networkingFailure = SwiftCustomObservable(())
        var recommendationDataList: SwiftCustomObservable<[Item]> = SwiftCustomObservable([])
        
        var sortData: SwiftCustomObservable<NaverSearch> = SwiftCustomObservable(NaverSearch(total: 0, items: []))
    }
    
    init() {
        input = Input()
        output = Output()
        
//        input.viewDidLoadTrigger.bind { _ in
//            print(#function)
//            self.callRequest()
//        }
        input.reload.lazyBind { _ in
            print(#function, "reload")
            self.callRequest()
        }
        
        input.sortType.lazyBind { _ in
            print(#function, "sort")
            self.callRequest()
        }
        
        input.startPage.lazyBind { _ in
            print(#function, "start")
            self.callRequest()
        }
        
        output.title.lazyBind { _ in
            print(#function, "title")
            self.callRequest()
        }
        
        input.sortButtonTapped.bind { sort in
            self.fetchForSort(sort: sort)
        }
    }
    
    private func callRequest() {
//        NetworkManager.shared.callRequest(query: output.title.data ?? "", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
//            self.output.total.data = success.total
//            self.output.successData.data = success
//        } failure: {
//            self.output.networkingFailure.data = ()
//        }
        print(#function)
        guard let searchTitle = output.title.data else {
            print("error: \(#function) - search: title is nil")
            return
        }
        print(searchTitle)
        NetworkManager.shared.callRequest(api: .search(query: searchTitle, start: input.startPage.data, display: 30, sort: input.sortType.data), decodedType: NaverSearch.self) { success in
            self.output.total.data = success.total
            self.output.successData.data = success
        } failure: {
            self.output.networkingFailure.data = ()
        }
        
//        NetworkManager.shared.callRequest(query: "키티", sort: SortType.accuracy.rawValue, startPosition: 1) { success in
//            self.output.recommendationDataList.data = success.items
//        } failure: { }
        NetworkManager.shared.callRequest(api: .recommend(display: "10"), decodedType: NaverSearch.self) { success in
            self.output.recommendationDataList.data = success.items
        } failure: { }
    }
    
    private func fetchForSort(sort: String) {
//        NetworkManager.shared.getNaverSearch(query: output.title.data ?? "", sort: sort, startPosition: 1) { success in
//            self.output.sortData.data = success
//            print(success)
//        } failure: {}
        
        guard let searchTitle = output.title.data else {
            print("error: \(#function) - search: title is nil")
            return
        }
        
        NetworkManager.shared.callRequest(api: .search(query: searchTitle, start: input.startPage.data, display: 30, sort: sort), decodedType: NaverSearch.self) { success in
            self.output.sortData.data = success
            self.output.successData.data = success
        } failure: {
            self.output.networkingFailure.data = ()
        }
    }
}
