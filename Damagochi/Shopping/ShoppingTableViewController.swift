//
//  ShoppingTableViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/10/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet var headerBackgroundView: UIView!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppinglistCell", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // MARK: - design
    func configureUI() {
        designHeaderBackgroundViewUI()
        designItemTextFieldUI()
        designAddButtonUI()
    }
    
    func designHeaderBackgroundViewUI() {
        headerBackgroundView.backgroundColor = .systemGray6
        headerBackgroundView.layer.cornerRadius = 8
        headerBackgroundView.clipsToBounds = true
    }
    
    func designItemTextFieldUI() {
        itemTextField.attributedPlaceholder = NSAttributedString(
            string: "무엇을 구매하실 건가요?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        itemTextField.backgroundColor = .systemGray6
        itemTextField.borderStyle = .none
    }
    
    func designAddButtonUI() {
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 8
        addButton.clipsToBounds = true
        let title = NSAttributedString(string: "추가",
                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                                    NSAttributedString.Key.foregroundColor: UIColor.black])
        addButton.setAttributedTitle(title, for: .normal)
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print(#function)
        if let text = itemTextField.text {
            shoppingList.append(text)
        } else {
            print("errer: \(#function) shoppingList.append(itemTextField.text)")
        }
        tableView.reloadData()
    }
    
}
