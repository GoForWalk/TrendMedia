//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    var movieList = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        movieList.append("마녀")
    }
    
    @IBAction func userTextFieldReturnTapped(_ sender: UITextField) {
       
        movieList.append(sender.text!)
        print(movieList)
        
        // 중요!! 데이터 갱신
        tableView.reloadData()
//        tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    // 이거 잘 확인해야함!!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = movieList[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
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
            tableView.reloadData()
        }
    }
    
}
