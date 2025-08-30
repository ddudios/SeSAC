//
//  RxViewModelProtocol.swift
//  ShoppingShopping
//
//  Created by Suji Jang on 8/31/25.
//

import Foundation

protocol RxViewModelProtocol {
    associatedtype RxInput
    associatedtype RxOutput
    
    func transform(rxInput: RxInput) -> RxOutput
}
