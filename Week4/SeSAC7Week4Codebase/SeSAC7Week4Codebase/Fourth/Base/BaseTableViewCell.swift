//
//  BaseTableViewCell.swift
//  SeSAC7Week4Codebase
//
//  Created by Suji Jang on 7/28/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            configureHierarchy()
            configureLayout()
            configureView()
        }
        
        func configureHierarchy() {
            print(#function)
        }
        
        func configureLayout() {
            print(#function)
        }
        
        func configureView() {
            print(#function)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
