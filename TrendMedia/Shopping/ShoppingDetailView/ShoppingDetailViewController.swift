//
//  ShoppingDetailViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/08/23.
//

import UIKit
import RealmSwift

class ShoppingDetailViewController: UIViewController {

    static let identifier = "ShoppingDetailViewController"
    
    let localRealm = try! Realm()
    
    var shoppingObject: Results<ShoppingList>!
    
    var objectUUID: String?
    let formatter: DateFormatter = DateFormatter()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var regDateLabel: UILabel!
    @IBOutlet weak var isDoneButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var initTitle: String?
    var initContent: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(objectUUID)
        setUI()
        getShoppingObject()
        
        titleTextField.delegate = self
        detailTextView.delegate = self
    }
 
    @IBAction func isDoneButtonTapped(_ sender: UIButton) {
        updateStatus(status: .check)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        updateStatus(status: .favorite)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        updateTitleAndContents()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: SetUI
extension ShoppingDetailViewController {
    
    func setUI() {
        [isDoneButton, favoriteButton, saveButton, detailTextView].forEach {
            $0?.layer.cornerRadius = 8
            $0?.clipsToBounds = true
        }
        
        saveButton.backgroundColor = .clear
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.isEnabled = false
        saveButton.setTitleColor(.black, for: .disabled)
        
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
        detailTextView.layer.borderWidth = 1
    }
    
    func ableSaveButton() {
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.borderColor = UIColor.systemGreen.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.isEnabled = true
        saveButton.setTitleColor(.white, for: .normal)
    }
}


// MARK: Model
extension ShoppingDetailViewController {
    
    func getShoppingObject() {
        
        guard let uuid = UUID(uuidString: objectUUID!) else { return }
        
        shoppingObject = localRealm.objects(ShoppingList.self).where {
            $0.uuid == uuid
        }
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        titleTextField.text =  shoppingObject.first?.shoppingTitle
        initTitle =  shoppingObject.first?.shoppingTitle
        regDateLabel.text = formatter.string(from: shoppingObject.first!.registerDate)
        detailTextView.text = shoppingObject.first?.shoppingDetailContent
        initContent = shoppingObject.first?.shoppingDetailContent
        setDoneButtonUI(status: shoppingObject.first!.isDone)
        setFavoriteButtonUI(status: shoppingObject.first!.isFavorite)
    }
    
    func updateStatus(status: ShoppingStatus) {
        switch status {
        case .check:
            let currentStatus: Bool = shoppingObject.first!.isDone
            
            try! localRealm.write {
                shoppingObject.first?.isDone = !currentStatus
            }
            setDoneButtonUI(status: !currentStatus)
        case .favorite:
            let currentStatus: Bool = shoppingObject.first!.isFavorite
            
            try! localRealm.write {
                shoppingObject.first?.isFavorite = !currentStatus
            }
            setFavoriteButtonUI(status: !currentStatus)
        }
    }
    
    func setDoneButtonUI(status: Bool) {
        switch status {
        case true:
            isDoneButton.layer.borderColor = UIColor.systemGreen.cgColor
            isDoneButton.layer.borderWidth = 1
            isDoneButton.tintColor = .systemGreen
            isDoneButton.backgroundColor = .clear
            isDoneButton.setTitle("구매했습니다!", for: .normal)
            isDoneButton.setTitleColor(.systemGreen, for: .normal)
        case false:
            isDoneButton.layer.borderColor = UIColor.systemRed.cgColor
            isDoneButton.layer.borderWidth = 1
            isDoneButton.tintColor = .systemRed
            isDoneButton.backgroundColor = .clear
            isDoneButton.setTitle("아직 못삿어요!!", for: .normal)
            isDoneButton.setTitleColor(.systemRed, for: .normal)
        }
    }

    func setFavoriteButtonUI(status: Bool) {
        switch status {
        case true:
            favoriteButton.layer.borderColor = UIColor.systemYellow.cgColor
            favoriteButton.layer.borderWidth = 1
            favoriteButton.tintColor = .clear
            favoriteButton.backgroundColor = .yellow
            favoriteButton.setTitle("즐겨찾기 등록 되었습니다", for: .normal)
            favoriteButton.setTitleColor(.black, for: .normal)
        case false:
            favoriteButton.layer.borderColor = UIColor.systemYellow.cgColor
            favoriteButton.layer.borderWidth = 1
            favoriteButton.tintColor = .systemYellow
            favoriteButton.backgroundColor = .clear
            favoriteButton.setTitle("즐겨찾기 등록 X", for: .normal)
            favoriteButton.setTitleColor(.systemRed, for: .normal)
        }
    }

    func updateTitleAndContents() {
        
        try! localRealm.write {
            
            guard let title = titleTextField.text else { return }
            
            shoppingObject.first?.shoppingTitle = title
            shoppingObject.first?.shoppingDetailContent = detailTextView.text
        }
        
    }
    
}

// MARK: UITextFieldDelegate
extension ShoppingDetailViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != initTitle {
            ableSaveButton()
        }
    }
    
}

extension ShoppingDetailViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != initContent {
            ableSaveButton()
        }
    }
    
}
