//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var db = MovieDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.dbase.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.movieDateLabel.text = db.dbase[indexPath.row].movieDate
        cell.movieTitleLabel.text = db.dbase[indexPath.row].movieTitle
        cell.movieDetailLabel.text = db.dbase[indexPath.row].movieDetail
//        cell.movieImageView.image = db.dbase[indexPath.row].movieImage
        
        cell.cellBaseView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
}

struct MovieDB {

    struct MovieData {
        
        var movieImage: UIImage?
        var movieTitle: String
        var movieDate: String
        var movieDetail: String
    }
    
    var dbase: [MovieData] = [MovieData(movieTitle: "해리포터 20주년: 리턴 투 호그와트(Harry Potter 20th Anniversery)", movieDate: "2022.01.01 | EN", movieDetail: "Class _PathPoint is implemented in both /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore (0x10fb87340) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextInputUI.framework/TextInputUI (0x1286c4fe8). One of the two will be used. Which one is undefined."), MovieData(movieTitle: "해리포터 20주년: 리턴 투 호그와트(Harry Potter 20th Anniversery)", movieDate: "2022.01.01 | EN", movieDetail: "Class _PathPoint is implemented in both /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore (0x10fb87340) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextInputUI.framework/TextInputUI (0x1286c4fe8). One of the two will be used. Which one is undefined.")]
    
}

