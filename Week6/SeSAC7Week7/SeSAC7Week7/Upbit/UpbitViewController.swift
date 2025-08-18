//
//  UpbitViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class UpbitViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    let viewModel = UpbitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = UpbitDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindData() {
        viewModel.input.viewDidLoadTrigger.value = ()  // 빈튜플로 시점의 신호만 전달
        
        // print가 안되니까 필요없겠네?
        viewModel.output.marketData.bind {
            print("viewController outputMarketData / list 변경")//, self.viewModel.outputMarketData.value)
            self.tableView.reloadData()  // 통신이 끝나e는 시점이 셀을 그리는 시점이 항상 다르기 때문에
        }
        
        viewModel.output.navigationTitleData.bind {
            print("viewController outputNavigationTitleData")
            let value = self.viewModel.output.navigationTitleData.value
            self.navigationItem.title = value
        }
        
        /*
        viewModel.outputCellSelected.bind {
            // 즉시 실행하니까 바로 화면전환해버림, 네트워크통신도 2번일어날 수 있음
            print("output", self.viewModel.outputCellSelected.value)  // 이제는 값이 들어있기 때문에 값을 확인 가능
            let vc = UpbitDetailViewController()
//            vc.koreanData = self.viewModel.outputCellSelected.value
            // 첫번째 뷰모델 데이터를 -> 두번째 뷰모델에 전달
            vc.viewModel.outputTitle.value = self.viewModel.outputCellSelected.value
            self.navigationController?.pushViewController(vc, animated: true)
        }
         */
        /**
         bind로 즉시 실행되어 화면 전환이 되고 있는 상황
         - lazyBind로 해결하거나 (의도는 이게 더 잘보이지만 항상 이 방법을 사용해야하나?)
         - optional이거나 빈 값일 때는 실행되지 않도록 early exit하거나
         */
        viewModel.output.cellSelected.bind {
            // 즉시 실행하니까 즉시 화면전환해버림
            print("viewController outputCellSelected / output", self.viewModel.output.cellSelected.value)  // 이제는 값이 들어있기 때문에 값을 확인 가능
            
            // 빈값일 때 조건으로 종료시켜서 이 아래 코드가 실행되지 않도록
            if self.viewModel.output.cellSelected.value.isEmpty {
                return
            }
            
            
            let vc = UpbitDetailViewController()
//            vc.koreanData = self.viewModel.outputCellSelected.value
            // 첫번째 뷰모델 데이터를 -> 두번째 뷰모델에 전달
            vc.viewModel.outputTitle.value = self.viewModel.output.cellSelected.value
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
         
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigationItems() {
        navigationItem.title = "마켓 목록"
    }
}

extension UpbitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
        return viewModel.output.marketData.value.count  // 실질적인 내용을 가져오면 [String]이고 그 갯수를 셀에 보여주기
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
//        cell.textLabel?.text = "비트코인 | KRW-BTC"
        let row = viewModel.output.marketData.value[indexPath.row]
        
//        cell.textLabel?.text = "\(row.korean_name) | \(row.english_name)"  // VC는 내부에 무슨 내용이 있는지 모르고 진짜 보여주기만 함
        // 이 부분도 연산이지 않나? -> Upbit에서 작업
        cell.textLabel?.text = row.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        // 지금은 살짝 억지지만, 2글자 미만이면 화면전환 X 같은 로직이 화면 전환에서도 나올 수도 있으니까..!
//        let vc = UpbitDetailViewController()
//        navigationController?.pushViewController(vc, animated: true)
        // 셀이 클릭됐을 때 이 셀이 뭔지는 몰라도 셀이 클릭됐다는 트리거만 던져주는 형태로 구성
        let row = viewModel.output.marketData.value[indexPath.row]
//        viewModel.inputCellSelectedTrigger.value = ()
        viewModel.input.cellSelected.value = row
    }
}
