//
//  TransitionViewController.swift
//  SeSAC7Week3
//
//  Created by Suji Jang on 7/15/25.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentButtonClicked(_ sender: UIButton) {
        // 1. 어떤 스토리보드에
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 2. 어떤 뷰컨트롤러를
//        let vc = YellowViewController()
        let vc = sb.instantiateViewController(withIdentifier: "YellowViewController") as! YellowViewController
        
        // 값전달
        vc.view.backgroundColor = .green  // 가능
        // 아웃렛이 늦게 만들어지기 때문에 TransitionVC에서 VC를 만들고, vc.testLabel은 스토리보드에서 늦게 만들어져서 앱이 종료돼야하는데.. 된다
        vc.testLabel.text = "새싹"
        vc.testLabel.backgroundColor = .red
        
        // 2.5. (옵션)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        // 3. 전환할 지
        present(vc, animated: true)
    }
    
    @IBAction func pushButtonClicked(_ sender: UIButton) {
        // 1. 어떤 스토리보드에
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 2. 어떤 뷰컨트롤러를
        let vc = sb.instantiateViewController(withIdentifier: "PurpleViewController") as! PurpleViewController
        // 3. 전환할 지
        navigationController?.pushViewController(vc, animated: true)
        // nil이면 navigationController?.에서 중지
        // nil이 아니면 끝까지 실행
        /*  // 3과 같은 코드
        if navigationController != nil {
            navigationController!.pushViewController(vc, animated: true)
        }
         */
    }
}
