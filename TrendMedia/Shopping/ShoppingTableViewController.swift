//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {

    // MARK: Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addShoppingListTextField: UITextField!
    
    @IBOutlet weak var addShoppingListButton: UIButton!
        
    private let identifier = "ShoppingTableViewCell"
    
    let localRealm = try! Realm()
    
    var task: Results<ShoppingList>! {
        didSet {
            self.tableView.reloadData()
            print("Task Updated")
        }
    }
    
    // MARK: ViewDidLoad(Scene Life Cycle Method)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 56
        tableView.separatorStyle = .singleLine
        getDataFromModel()
        setUI()
        setNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getDataFromModel()
        print(localRealm.configuration.fileURL!)
//        tableView.reloadData()
    }
    
    // MARK: TableView Delegate, DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell()}
        
        cell.shoppingListLabel.text = task[indexPath.row].shoppingTitle
        cell.checkBoxButton.tag = indexPath.row
        cell.favoriteCheckButton.tag = indexPath.row
        
        cell.checkBoxButton.setImage(setButtonImage(statusType: .check, currentStatus: task[indexPath.row].isDone), for: .normal)
        
        cell.favoriteCheckButton.setImage(setButtonImage(statusType: .favorite, currentStatus: task[indexPath.row].isFavorite), for: .normal)
        
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = CGColor(gray: 0, alpha: 0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in
            
            self.deleteShoppingRecord(index: indexPath.row)
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ShoppingDetailViewController.identifier) as? ShoppingDetailViewController else { return }
        
        vc.objectUUID = task[indexPath.row].uuid.description
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: IBAction
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addShoppingList()
    }
    
    @IBAction func addShoppingListReturnTapped(_ sender: UITextField) {
        addShoppingList()
        sender.text = ""
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        print(#function, sender, sender.tag)
        changeShoppingStatus(statusType: .check, index: sender.tag)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        print(#function, sender, sender.tag)
        changeShoppingStatus(statusType: .favorite, index: sender.tag)
    }
        
}

// MARK: UI set
extension ShoppingTableViewController {
    
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

    func setButtonImage(statusType: ShoppingStatus, currentStatus: Bool) -> UIImage {
        
        switch statusType {
        case .check:
            switch currentStatus {
            case true: return UIImage(systemName: "checkmark.square.fill")!
            case false: return UIImage(systemName: "checkmark.square")!
            }
            
        case .favorite:
            switch currentStatus {
            case true: return UIImage(systemName: "star.fill")!
            case false: return UIImage(systemName: "star")!
            }

        }
    }

    func setNav() {
        
        let barButtonMenu = UIMenu(title: "", options: [], children: [
            UIAction(title: "전체", image: UIImage(systemName: "list.bullet.clipboard"), handler: { _ in
                self.getDataFromModel()
            }),
            
            UIAction(title: "살것", image: UIImage(systemName: "cart"), state: .off, handler: { _ in
                self.getNotBuyShoppingList()
            }),
            
            UIAction(title: "즐겨찾기", image: UIImage(systemName: "star.fill"), state: .off, handler: { _ in
                self.getFavoriteShoppingList()
            })
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "정렬", image: nil, primaryAction: nil, menu: barButtonMenu)
    }
    
}

// MARK: Model 작업
extension ShoppingTableViewController {
    
    
    func getDataFromModel() {
        task = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "registerDate", ascending: true)
    }
    
    func getFavoriteShoppingList(){
        task = localRealm.objects(ShoppingList.self)
            .where {
                $0.isFavorite == true
            }.sorted(byKeyPath: "registerDate", ascending: true)
    }
    
    func getNotBuyShoppingList() {
        task = localRealm.objects(ShoppingList.self)
            .where {
                $0.isDone == false
            }.sorted(byKeyPath: "registerDate", ascending: true)
    }
    
    func addDataToModel(shoppingTitle: String,  completionHandler: @escaping () -> ()) {
        let addData = ShoppingList(shoppingTitle: shoppingTitle)
        
        try! localRealm.write {
            localRealm.add(addData)
            completionHandler()
        }
    }

    func addShoppingList() {
        guard let word =  addShoppingListTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        addDataToModel(shoppingTitle: word) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func changeShoppingStatus(statusType: ShoppingStatus, index: Int) {
        
        let changeTask = task[index]
        
        switch statusType {
        case .check:
            let currentStatus = changeTask.isDone
            try! localRealm.write {
                changeTask.isDone = !currentStatus
                self.tableView.reloadData()
            }
            return
            
        case .favorite:
            let currentStatus = changeTask.isFavorite
            try! localRealm.write {
                changeTask.isFavorite = !currentStatus
                self.tableView.reloadData()
            }
            return
        }
        
    }
    
    func deleteShoppingRecord(index: Int) {
        
        do{
            try localRealm.write {
                localRealm.delete(task[index])
            }
            
            tableView.reloadData()
        } catch ModelError.deadLock {
            print("DEADLOCK")
        } catch {
            print("Error")
        }
    }

}

enum ShoppingStatus {
    case check, favorite
}

enum ShoppingSortType {
    case all, favorite, notBuy
}

enum ModelError: Error {
    case deadLock
}
