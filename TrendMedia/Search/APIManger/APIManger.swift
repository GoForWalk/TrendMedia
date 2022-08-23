//
//  APIManger.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/08/22.
//

import Foundation

import Alamofire
import SwiftyJSON

enum EndPoint {
    static let moviewEndPoint = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    
    static let parma_key = "key"
    static let param_targetDt = "targetDt"
}

struct movieInfo {
    
    let rank: String // rank
    let isNew: Bool // rankOldAndNew
    let movieName: String // movieNm
    let openDate: String // openDt
    let audiChange: String // audiChange
    let date: String
}

class MoviewAPIManger {
    
    static let shared = MoviewAPIManger()
    
    private init() { }
    
    private let formatter = DateFormatter()
    
    func fetchMovieData(completionHandler: @escaping ([movieInfo]) -> ()) {
        
        formatter.timeZone = TimeZone(identifier: "ko_KR")
        formatter.dateFormat = "yyyyMMdd"
        
        let date = formatter.string(from: Date())
        
        let param: Parameters = [EndPoint.parma_key: MoviewAPIKey.APIKEY, EndPoint.param_targetDt: date]
        
        AF.request(EndPoint.moviewEndPoint, method: .get, parameters: param).validate().responseData { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
                
                let movieList = json["boxOfficeResult"]["dailyBoxOfficeList"]
                
                let result = movieList.arrayValue.map { movie -> movieInfo in
                    let rank = movie["rank"].stringValue
                    let isNew = movie["rankOldAndNew"].stringValue == "OLD" ? false : true
                    let movieName = movie["movieNm"].stringValue
                    let openDate = movie["openDt"].stringValue
                    let audiChange = movie["audiChange"].stringValue
                    
                    return movieInfo(rank: rank, isNew: isNew, movieName: movieName, openDate: openDate, audiChange: audiChange, date: date)
                }
                
                completionHandler(result)
                
                
            case .failure(let error):
                print("error: ", error)
            }
        }
    }
    
    
}
