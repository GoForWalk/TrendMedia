//
//  ViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    // 아웃렉 컬렉션을 사용하는 것이 좋을까?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var yellowViewLeadingConstrant: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yellowViewLeadingConstrant.constant = 20
        
        // 1. OutletCollection
        
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        
        // UILabel
        let labelArray = [dateLabel, date2Label]

        for i in labelArray {
            i?.font = .boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
        
    }

    @IBAction func datePickerValueChaged(_ sender: UIDatePicker) {
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy/MM/dd"
        
        dateLabel.text = format.string(from: sender.date)
        
    }
    

}

