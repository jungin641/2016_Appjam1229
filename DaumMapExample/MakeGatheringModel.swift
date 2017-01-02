//
//  MakeGatheringModel.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 1..
//  Copyright © 2017년 JunginYu. All rights reserved.
//


import Alamofire
import SwiftyJSON

class MakeGatheringModel: NetworkModel {
    let userDefault = UserDefaults.standard
    // 방 만들기 ( +버튼 눌러서 공개 비공개 중 선택해서 클릭 했을 때)
    func getFriendsList() {
     //   let id = userDefault.string(forKey: "id")
        let id = "1"
        Alamofire.request("\(baseURL)/room/create/\(id)").responseJSON()   { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    var tempList = [FriendVO]()
                    if let array = data["friend_list"].array{
                        for item in array{
                            let fvo = FriendVO(name: item["name"].string,
                                               profile: item["profile"].string,
                                               id: item["id"].string)
                            tempList.append(fvo)
                        }
                        
                        self.view.networkResult(resultData: tempList, code: 0)
                    }
                }
                break
                
            case .failure :
                self.view.networkFailed()
            }
        }
    }
    
}
