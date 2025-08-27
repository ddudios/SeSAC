//
//  DetailViewModel.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/27/25.
//

import Foundation
import RxSwift

final class DetailViewModel: ViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        let title: Observable<String>
    }
    
    private let navigationTitle: String
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
    }
    
    func transform(input: Input) -> Output {
        let title = Observable.just(navigationTitle)
        return Output(title: title)
    }
}
