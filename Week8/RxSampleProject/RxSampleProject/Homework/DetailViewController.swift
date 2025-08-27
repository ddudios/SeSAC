//
//  DetailViewController.swift
//  RxBasic
//
//  Created by Suji Jang on 8/22/25.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }
    
    private func bind() {
        let input = DetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.title
            .asDriver(onErrorJustReturn: "Title 전달 에러")
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
