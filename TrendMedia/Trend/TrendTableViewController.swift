//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        
        // 화면 전환: 1. 스토리보드 파일 찾기 2. 스토리보드 내에 뷰컨트롤러 3. 화면 전환
        // 영화 버튼 클릭 > BucketListTableViewController Present
        
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        // 3.
        self.present(vc, animated: true)
        
    }
    
    @IBAction func dramaButtonTapped(_ sender: UIButton) {
        
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 2.5 -> viewController를 present할 때 띄우는 방식
        vc.modalPresentationStyle = .fullScreen
        
        // 3.
        self.present(vc, animated: true)
    }
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        // 2.5 navigationController를 embed하여 present
        let nav = UINavigationController(rootViewController: vc)
        
        // 2.5 -> viewController를 present할 때 띄우는 방식
        nav.modalPresentationStyle = .fullScreen
        
        // 3. -> nav를 띄워줘야한다.
        self.present(nav, animated: true)

        
    }
    
}//: TrendTableViewController
