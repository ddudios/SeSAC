//
//  ShoppingTableViewController.swift
//  Damagochi
//
//  Created by Suji Jang on 7/10/25.
//

import UIKit

struct ShoppingListManager {
    var shoppingList: String
    var isBookmark: Bool = Bool.random()
    var isChecked: Bool = Bool.random()
}

class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet var headerBackgroundView: UIView!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
//    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    var shoppingList = [
        ShoppingListManager(shoppingList: "그립톡 구매하기"),
        ShoppingListManager(shoppingList: "사이다 구매"),
        ShoppingListManager(shoppingList: "아이패드 케이스 최저가 알아보기"),
        ShoppingListManager(shoppingList: "양말")
    ]
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppinglistCell", for: indexPath) as! ShoppingListTableViewCell
        
        designBackgroundViewUI(cell.shoppingListBackgroundView)
        
        shoppingList[indexPath.row].isChecked ? designAccessoryButtonUI(cell.checkButton, image: "checkmark.square.fill") : designAccessoryButtonUI(cell.checkButton, image: "checkmark.square")
        
        shoppingList[indexPath.row].isBookmark ? designAccessoryButtonUI(cell.bookmarkButton, image: "star.fill") : designAccessoryButtonUI(cell.bookmarkButton, image: "star")
        
        designLabelUI(cell.shoppingListLabel)
        
        cell.shoppingListLabel.text = shoppingList[indexPath.row].shoppingList
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shoppingList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - design
    func configureUI() {
        designBackgroundViewUI(headerBackgroundView)
        designItemTextFieldUI()
        designAddButtonUI()
    }
    
    func designBackgroundViewUI(_ view: UIView) {
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    func designItemTextFieldUI() {
        itemTextField.attributedPlaceholder = NSAttributedString(
            string: "무엇을 구매하실 건가요?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        itemTextField.backgroundColor = .systemGray6
        itemTextField.borderStyle = .none
        itemTextField.tintColor = .black
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
    
    func designAccessoryButtonUI(_ bt: UIButton, image: String) {
        bt.tintColor = .black
        bt.setImage(UIImage(systemName: image), for: .normal)
    }
    
    func designLabelUI(_ lb: UILabel) {
        lb.font = CustomFont.shoppingList
        lb.numberOfLines = 0
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print(#function)
        if let text = itemTextField.text {
            shoppingList.append(ShoppingListManager(shoppingList: text))
        } else {
            print("errer: \(#function) shoppingList.append(itemTextField.text)")
        }
        
        tableView.reloadData()
    }
    
}
