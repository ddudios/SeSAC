//
//  SearchPhotoViewModel.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/18/25.
//

import Foundation

final class SearchPhotoViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var reload = Observable(())
        var textField = Observable("")
    }
    
    struct Output {
        var searchResult: Observable<Search> = Observable(Search(results: []))
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.reload.lazyBind { _ in }
        
        input.textField.lazyBind { text in
            self.callRequest(keyword: text, page:"1", orderBy: "latest", color: "black")
        }
    }
    
    private func callRequest(keyword: String, page: String, orderBy: String, color: String) {
        NetworkMananger.shared.callRequest(api: .search(keyword: keyword, page: page, order_by: orderBy, color: color), type: Search.self) { success in
            self.output.searchResult.data = success
        } failure: { error in
            print("errer: \(error)")
        }
    }
}
