//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    private final let cellName: String = "settingCell"
    
    var birthdayFriends = ["고래밥", "칙촉", "뽀로로", "신데렐라", "스노우"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3-1. viewDidLoad에서 프로퍼티로 일괄적으로 지정하는 경우
        tableView.rowHeight = 80
    }
    
    // 섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // section : 배열형식으로 나열되어 있다. -> 그 배열의 index라고 생각하면 된다.
        
        if section == 0 {
            return "생일"
        }
        
        return "Section Header"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Section Footer"
    }
    
    // 1. 셀의 갯수(필수)
    // ex. 카톡 친구 100명 -> 셀의 갯수 셀 100개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // numberOfRowsInSection: 섹션안에 들어 있는 셀의 개수
        
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
        
        // 셀의 개수를 리턴한다.
//        return 10
    }
    
    
    // 2. 셀의 디자인과 데이터를 넣는 작업(필수)
    // ex. 카톡 이점팔, 프로필 사진, 상태 메세지 등
    // 재사용 메커니즘
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt", indexPath)

        // 다른 형태를 가진 tableCell에 다른 identifier를 통해 사용할 수 있다.
        if indexPath.section == 2 {
            // dequeueReusableCell 함수에서 재사용 메커니즘 사용된다.
            // dequeue
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            
            cell.textLabel?.text = "2번 인덱스 셀 텍스트"
            cell.textLabel?.textColor = .orange
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = "디테일 레이블"
            
            // indexPath.row % 2 ==
//            cell.imageView?.image = UIImage(systemName: "star.fill")
            
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName)!

            if indexPath.section == 0 {
                cell.textLabel?.text = birthdayFriends[indexPath.row]
                cell.textLabel?.textColor = .brown
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
                
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "1번 인덱스 셀 텍스트"
                cell.textLabel?.textColor = .green
                cell.textLabel?.font = .boldSystemFont(ofSize: 25)
            }

            return cell
        }
        
        
        
        // 셀 개수만큼 반복 실행하는 코드
        // * 10

        // indexPath
        // indexPath.row
        // indexPath.section

        // Section 그룹별로 별도 설정 가능
 
        
//        cell.textLabel?.text = "셀 텍스트"
//        cell.textLabel?.textColor = .brown
//        cell.textLabel?.font = .boldSystemFont(ofSize: 20)

    }
    
    // 3. cell 높이를 부여하는 함수(옵션)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
