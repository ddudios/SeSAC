//
//  BaseViewModel.swift
//  Tamagotchi
//
//  Created by Suji Jang on 8/26/25.
//

import Foundation

protocol BaseViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
