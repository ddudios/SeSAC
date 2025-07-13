//
//  GameViewController.swift
//  Travel
//
//  Created by Suji Jang on 7/12/25.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameMaxNumberTextField: UITextField!
    @IBOutlet var gameTextView: UITextView!
    @IBOutlet var gameResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureGameMaxNumberTextFieldUI(gameMaxNumberTextField)
        configureGameTextViewUI(gameTextView)
        configureGameResultLabelUI(gameResultLabel)
    }
    
    func configureGameMaxNumberTextFieldUI(_ tf: UITextField) {
        tf.keyboardType = .numbersAndPunctuation
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.placeholder = "최대 숫자를 입력해주세요"
        tf.textAlignment = .center
        tf.tintColor = .black
        tf.font = CustomFont.headline
    }
    
    func configureGameTextViewUI(_ tv: UITextView) {
        tv.textColor = .gray
        tv.textAlignment = .center
        tv.font = CustomFont.subtitle
        tv.isEditable = false
    }
    
    func configureGameResultLabelUI(_ lb: UILabel) {
        lb.font = CustomFont.headline
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.text = ""
    }
    
    // 숫자1~입력숫자를 텍스트뷰에 String으로 추가하면서, String에 3, 6, 9가 포함되어 있다면 이모지로 대체
    func replaceClap(max: String?) {
        let maxNumber = Int(max!)
        
        guard let nonOptionalMaxNumber = maxNumber else {
            print("error: \(#function) - max: optional binding - Fail")
            return
        }
        
        for num in 1...nonOptionalMaxNumber {
            let numString = String(num)
            if numString.contains("3") || numString.contains("6") || numString.contains("9") {
                gameTextView.text += "👏, "
            } else {
                gameTextView.text += "\(num), "
            }
        }
        
        gameTextView.text.removeLast(2)
    }
    
    // TextView에 숫자1~입력숫자까지 String으로 추가해서 화면에 보여주고 끝의 ", " 제거
    func showTextView(max: String?) {
            let maxNumber = Int(max!)
            
            guard let nonOptionalMaxNumber = maxNumber else {
                print("error: \(#function) - max: optional binding - Fail")
                return
            }
            
            for num in 1...nonOptionalMaxNumber {
                gameTextView.text += "\(num), "
            }
            
            gameTextView.text.removeLast(2)
    }
    
    // 전체 문자열를 돌면서 "3", "6", "9"를 이모지로 대체
    func replaceNumber() {
        gameTextView.text = gameTextView.text
            .replacingOccurrences(of: "3", with: "👏")
            .replacingOccurrences(of: "6", with: "👏")
            .replacingOccurrences(of: "9", with: "👏")
    }
    
    // 전체 문자열을 돌면서 이모지에 해당하면 카운팅+
    func countingClap() {
        var countClap = 0
        gameTextView.text.forEach { clap in
            if clap == "👏" {
                countClap += 1
            }
        }
        
        gameResultLabel.text = "숫자 \(gameMaxNumberTextField.text!)까지 총 박수는 \(countClap)번입니다."
    }
    
    @IBAction func backgroundGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
//        replaceClap(max: sender.text)
        showTextView(max: sender.text)
        replaceNumber()
        countingClap()
    }
}
