//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit
import RealmSwift

class SearchTableViewController: UITableViewController {
    
    static let identifier = "SearchTableViewController"
    
    @IBOutlet weak var datePicker: UIDatePicker!
    //    var db = MovieDB()
    
    let localRealm = try! Realm()
    
    var movieRank: Results<MovieModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonClicked))
        
    }
    
    func getDataFromModel(date: Date) {
        
        movieRank = localRealm.objects(MovieModel.self).where {
            ($0.date == date)
        }
        
    }
    
    func checkModel() {
        
    }
    
    @objc func resetButtonClicked() {

        
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieRank.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
//        cell.configureCell(indexPath: indexPath, db: db)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RecommandCollectionViewController.identifier) as! RecommandCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 값 추가
//        vc.moviData = db.movieDataList[indexPath.row]
        
        // push
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
}


