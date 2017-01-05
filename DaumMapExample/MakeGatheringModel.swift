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
        let my_id = userDefault.string(forKey: "id")
        
        Alamofire.request("\(baseURL)/room/create/\(gsno(my_id))").responseJSON()  { res in // 맨 끝의 인자가 함수면 클로저 사용 가능
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    var tempList = [FriendVO]()
                    if let array = data["friend_list"].array{
                        for item in array{
                            let fvo = FriendVO(name: item["name"].string,
                                               profile: item["profile"].string,
                                               id: item["id"].int)
                            tempList.append(fvo)
                        }
                        
                        self.view.networkResult(resultData: tempList, code: 0)
                    }
                }
                
                
                break
                
            case .failure(let err) :
                print(err)
                self.view.networkFailed()
            }
        }
    }
    func roomDetail(meeting_id : Int) {
        let my_id = userDefault.string(forKey: "id")
        
        Alamofire.request("\(baseURL)/room/detail/\(gsno(my_id))/\(gino(meeting_id))").responseJSON()  { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    var participantsTempList = [Participants]()
                    var roomInfoTempList = [RoomInfo]()
                    var datesTempList = [Dates]()
                    
                    if let array = data["participants"].array{
                        for item in array{
                            let participants = Participants(name: item["name"].string, is_input: item["is_input"].string, place: item["place"].string, longitude: item["longitude"].string, latitude: item["latitude"].string)
                            participantsTempList.append(participants)
                        }
                        
                        
                    }
                    if let room_info = data["room_info"].array{
                        for item in room_info{
                            let rvo = RoomInfo(title: item["title"].string, text: item["text"].string, is_open: item["text"].int, when_fix: item["when_fix"].int, where_fix: item["where_fix"].int, room_image: item["room_image"].string, host: item["host"].string,hostprofile: item["host_profile"].string)
                            roomInfoTempList.append(rvo)
                        }
                        
                        
                    }
                    if let dates = data["dates"].array{
                        for item in dates{
                            let dvo = Dates(date: item["date"].string, count: item["count"].int)
                            datesTempList.append(dvo)
                        }
                        
                        //self.view.networkResult(resultData: "", code: 0)
                    }
                    
                    if let my_meeting_id = data["my_meeting_id"].int{
                        //나중에 저장해두고 필요할 때 보내주기만 하면 됨
                        // 약속관계 key
                        self.userDefault.set(my_meeting_id, forKey: "my_meeting_id")
                      
                        
                    }
                    let roomDetail = GatheringVO(participants: participantsTempList, roomInfo: roomInfoTempList, dates: datesTempList)
                    
                    self.view.networkResult(resultData: roomDetail, code: 0)
                }
                break
                
            case .failure(let err) :
                print(err)
                self.view.networkFailed()
            }
        }
    }
    
    
    
}
