//
//  MovieModel.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/08/22.
//

import Foundation
import RealmSwift

class MovieModel: Object {
    
    @Persisted var rank: String
    @Persisted var inNew: Bool
    @Persisted var movieName: String
    @Persisted var openDate: String
    @Persisted var audiChange: String
    @Persisted var date: Date
    
    convenience init(rank: String, isNew: Bool, movieName: String, openDate: String, audiChange: String, date: Date) {
        self.init()
        self.rank = rank
        self.inNew = inNew
        self.movieName = movieName
        self.openDate = openDate
        self.audiChange = audiChange
        self.date = date
    }
    
}
