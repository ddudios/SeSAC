//
//  DetailViewController.swift
//  Mbti
//
//  Created by Suji Jang on 9/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: BaseViewController {
    private let dataLabel = UILabel()
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
        
        viewModel.transform().receiveData
            .bind(to: dataLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(dataLabel)
    }
    
    override func configureLayer() {
        dataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
    }
}

final class DetailViewModel {
    private let receiveData: String
    
    init(receiveData: String) {
        self.receiveData = receiveData
    }
    
    struct Output {
        let receiveData: Observable<String>
    }
    
    func transform() -> Output {
        return Output(receiveData: Observable.just(receiveData))
    }
}
