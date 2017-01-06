//
//  MapModel.swift
//  Huddle
//
//  Created by  noldam on 2017. 1. 6..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MapModel: NetworkModel {
    
    func daumKeywordSearch(query: String) {
        
        let params : [String:String] = [
            "query" : query,
            "apikey" : "ad94ca8d3398bf222fd6e5acbbb8f96d"
        ]
        
        let url = "https://apis.daum.net/local/v1/search/keyword.json"
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { res in

            switch res.result {
            case .success:
                if let value = res.result.value {
                    let data = JSON(value)
                   
                        if let array = data["channel"]["item"].array{
                        for position in array{
                           print(position["latitude"].string)
                            print(position["longitude"].string)
                            print(position["title"].string)
                            
                        }
                        
                        self.view.networkResult(resultData: "", code: 0)
                    
                    }
//                    self.view.networkResult(resultData: value, code: 0)
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }
    }
    
}
