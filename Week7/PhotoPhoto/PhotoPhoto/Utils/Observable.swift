//
//  Observable.swift
//  PhotoPhoto
//
//  Created by Suji Jang on 8/17/25.
//

import Foundation

final class Observable<T> {
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
