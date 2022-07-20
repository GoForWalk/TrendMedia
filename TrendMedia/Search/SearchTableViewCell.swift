//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBaseView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(indexPath: IndexPath, db: MovieDB){
        
        movieDateLabel.text = "\(db.movieDataList[indexPath.row].movieDate) | \(db.movieDataList[indexPath.row].movieRuntime!)분 | 평점: \(db.movieDataList[indexPath.row].movieRate)"
        movieTitleLabel.text = db.movieDataList[indexPath.row].movieTitle
        movieDetailLabel.text = db.movieDataList[indexPath.row].movieDetail
        movieImageView.image = db.movieDataList[indexPath.row].movieImage
        cellBaseView.backgroundColor = UIColor.white.withAlphaComponent(0)

    }
    

}
