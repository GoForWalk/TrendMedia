//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}


class BucketListTableViewController: UITableViewController {
    
    static let identifier = "BucketListTableViewController"
    
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("textField Didset")
        }
    }
    
    var placeholderString: String = ""
    
    // list property가 추가, 삭제등 변경 되고나서 테이블뷰를 항상 갱신
    var movieList = [Todo(title: "탑건", done: false), Todo(title: "토르", done: false)] {
        didSet {
            tableView.reloadData()
            print("List가 변경됨 \(movieList), \(oldValue)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        userTextField.placeholder = placeholderString
        movieList.append(Todo(title: "마녀", done: false))
        
        // nav 영역 편집
        setNavgationBar()
    }
    
    @IBAction func userTextFieldReturnTapped(_ sender: UITextField) {
       
        guard let userText = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !userText.isEmpty, (2...6).contains(userText.count) else { return }
        
        movieList.append(Todo(title: userText, done: false))
        print(movieList)
        
        // 중요!! 데이터 갱신
//        tableView.reloadData()
//        tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    // 이거 잘 확인해야함!!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = movieList[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
        
        // UI 변경
        let value = movieList[indexPath.row].done ? "checkmark.square" : "checkmark.square.fill"
        
        cell.checkBoxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    // cell들의 편집이 가능하도록 한다.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Swipe
    // leading Swipe
    // trailing Swipe
    
    
    // 우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열 삭제 후 리로드
            movieList.remove(at: indexPath.row)
//            tableView.reloadData()
        }
    }
  
    func setNavgationBar() {
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc
    func checkBoxButtonTapped(sender: UIButton) {
        // 데이터만 변경
        movieList[sender.tag].done = !movieList[sender.tag].done
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        print("\(sender.tag) button Tapped")
    }
}
