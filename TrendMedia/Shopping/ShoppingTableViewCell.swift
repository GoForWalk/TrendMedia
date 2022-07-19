//
//  ShoppingTableViewCell.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var favoriteCheckButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUI() {
        
    }
    
    func setCellUI() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
