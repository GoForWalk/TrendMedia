//
//  PracSettingTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/18.
//

import UIKit

class PracSettingTableViewController: UITableViewController {

    private let sections: [String] = ["전체 설정", "개인 설정", "기타"]
    
    private let publicSetting: [String] = ["공지사항", "실험실", "버전 정보"]
    
    private let privateSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    private let etcSetting = ["고객센터/도움말"]
    
    private let identifier = "settingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return publicSetting.count
        case 1: return privateSetting.count
        case 2: return etcSetting.count
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = publicSetting[indexPath.row]
        case 1:
            cell.textLabel?.text = privateSetting[indexPath.row]
        case 2:
            cell.textLabel?.text = etcSetting[indexPath.row]
        default:
            cell.textLabel?.text = ""
            
        }
        
        return cell
    }

}
