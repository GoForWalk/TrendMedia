//
//  TableViewCell.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {

    static let identifier = "BucketListTableViewCell"
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
