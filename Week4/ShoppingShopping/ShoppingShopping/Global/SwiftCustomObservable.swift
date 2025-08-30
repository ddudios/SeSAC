//
//  Observable.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/12/25.
//

import Foundation

final class SwiftCustomObservable<T> {
    private var ready: ((T) -> Void)?
    
    var data: T {
        didSet {
            ready?(data)
        }
    }
    
    init(_ value: T) {
        self.data = value
    }
    
    func bind(action: @escaping (T) -> Void) {
        action(data)
        ready = action
    }
    
    func lazyBind(action: @escaping (T) -> Void) {
        ready = action
    }
}
