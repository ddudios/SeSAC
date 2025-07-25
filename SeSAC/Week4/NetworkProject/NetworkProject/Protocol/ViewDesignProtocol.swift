//
//  File.swift
//  NetworkProject
//
//  Created by Suji Jang on 7/23/25.
//

import Foundation

@objc protocol ViewDesignProtocol {
    func configureHierarchy()
    func configureLayout()
    func configureView()
    @objc optional func configureNavigationBar()
}
