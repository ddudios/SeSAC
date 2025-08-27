//
//  ViewModelProtocol.swift
//  RxSampleProject
//
//  Created by Suji Jang on 8/27/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
