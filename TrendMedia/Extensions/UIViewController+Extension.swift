//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/19.
//

import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "a", message: "aa", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ㅇㅅㅇ", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
