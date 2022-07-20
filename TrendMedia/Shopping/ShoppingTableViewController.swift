//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addShoppingListTextField: UITextField!
    
    @IBOutlet weak var addShoppingListButton: UIButton!
    
    private let identifier = "ShoppingTableViewCell"
    
    var db = ShoppingListDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 56
        
        tableView.separatorStyle = .singleLine
        
        setUI()
    }
    
    func setUI() {
        addShoppingListTextField.placeholder = "무엇을 구매하실 건가요?"
        addShoppingListTextField.backgroundColor = .systemGray6
        headerView.backgroundColor = .systemGray6
        headerView.layer.cornerRadius = 12
        headerView.clipsToBounds = true

        addShoppingListButton.backgroundColor = .systemGray5
        addShoppingListButton.layer.cornerRadius = 12
        addShoppingListButton.clipsToBounds = true
        
        headerView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.getDataCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        
        cell.shoppingListLabel.text = db.getShoppingList()[indexPath.row]
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = CGColor(gray: 0, alpha: 0)
        
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addShoppingList()
    }
    
    @IBAction func addShoppingListReturnTapped(_ sender: UITextField) {
        addShoppingList()
    }
    
    func addShoppingList() {
        guard let word =  addShoppingListTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        db.addShoppingList(word: word)
        tableView.reloadData()
    }
}

struct ShoppingListDB {
    
    private struct ShoppingList {
        var shoppingList: String
        var isChecked: Bool = false
        var isFavorite: Bool = false
    }
    
    private var dataForm: [ShoppingList] = [ShoppingList(shoppingList: "그립톡 구매하기"), ShoppingList(shoppingList: "사이다 구매"), ShoppingList(shoppingList: "아이폰 사기", isChecked: true, isFavorite: true)]
    
    func getDataCount() -> Int {
        return dataForm.count
    }
    
    func getShoppingList() -> [String] {
        return dataForm.map {
            return $0.shoppingList
        }
   }
    
    mutating func addShoppingList(word: String) {
        dataForm.append(ShoppingList(shoppingList: word))
    }
    
}
