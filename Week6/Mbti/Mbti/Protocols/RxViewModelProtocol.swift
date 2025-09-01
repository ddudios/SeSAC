//
//  RxViewModelProtocol.swift
//  Mbti
//
//  Created by Suji Jang on 9/1/25.
//

import Foundation

protocol RxViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
