//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    static let identifier = "SearchTableViewController"
    
    var db = MovieDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonClicked))
        
    }
    
    @objc func resetButtonClicked() {
        
        // iOS13+ SceneDelegate를 쓸 때 동작하는 코드
        // 앱을 처음 실행하는 것 처럼 동작하게 한다.
        // SceneDelegate 밖에서 window에 접근하는 방법
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 생명주기 담당
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = UIStoryboard(name: "Trend", bundle: nil).instantiateViewController(withIdentifier: "WellcomViewController") as! WellcomViewController
        
        // window에 접근
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.movieDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(indexPath: indexPath, db: db)
        
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
        vc.moviData = db.movieDataList[indexPath.row]
        
        // push
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
}


