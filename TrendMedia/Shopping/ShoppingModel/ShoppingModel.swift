//
//  ShoppingModel.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/08/22.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    
    @Persisted(primaryKey: true) var uuid: UUID
    
    @Persisted var shoppingTitle: String
    @Persisted var isDone: Bool
    @Persisted var isFavorite: Bool
    @Persisted var shoppingDetailContent: String?
    @Persisted(indexed: true) var registerDate: Date

    
    convenience init(shoppingTitle: String, isDone: Bool = false, isFavorite: Bool = false) {
        self.init()
        self.shoppingTitle = shoppingTitle
        self.isDone = isDone
        self.isFavorite = isFavorite
        self.shoppingDetailContent = nil
        self.registerDate = Date()
    }
    
}
