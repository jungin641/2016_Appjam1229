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
//    내방 상세보기 API
//    8번 통신
        func roomDetail(meeting_id : Int) {
        let my_id = userDefault.string(forKey: "id")
        
        Alamofire.request("\(baseURL)/room/detail/\(gsno(my_id))/\(meeting_id)").responseJSON()  { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    var participantsTempList = [Participants]()
                    var roomInfoTempList = [RoomInfo]()
                    var datesTempList = [Dates]()
                    
                    if let array = data["participants"].array{
                        for item in array{
                            let participants = Participants(
                                name: item["name"].string,
                                is_input: item["is_input"].string,
                                place: item["place"].string,
                                longitude: self.gdno(Double(self.gsno(item["longitude"].string))),
                                latitude: self.gdno(Double(self.gsno(item["latitude"].string))))
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
                    let roomDetail = GatheringVO(participants: participantsTempList, roomInfos: roomInfoTempList, dates: datesTempList)
                    
                    self.view.networkResult(resultData: roomDetail, code: 0)
                }
                break
                
            case .failure(let err) :
                print(err)
                self.view.networkFailed()
            }
        }
    }
    // 방 만들기 완료 버튼 누를 때 ( 방 정보 다 선택하고 최종적으로 완료 버튼 누를 때)
    //5번 통신
    func roomCreate(gatheringVO : GatheringVO) {
        var partinames = [String]()
        var sendDays = [String]()
        var sendRoomInfo = RoomInfo()
        if let nparti = gatheringVO.participants{
            for parti in nparti{
            partinames.append(gsno(parti.name))
            }}
        if let nodays = gatheringVO.days{
            sendDays = nodays
        }
        if let noroomInfo = gatheringVO.roomInfo{
            sendRoomInfo = noroomInfo
        }
        let meeting = [
                "host_id" : gino(sendRoomInfo.host_id), //방장의 id(본인 id)
                "title" : gsno(sendRoomInfo.title),
                "text" : gsno(sendRoomInfo.text),
                "is_open" : gino(sendRoomInfo.is_open),
                "when_fix" : gino(sendRoomInfo.when_fix),
                "where_fix" : gino(sendRoomInfo.where_fix)
            ] as [String : Any]
        let position = [
            "place" : gsno(gatheringVO.position?.place) ,//방장의 id(본인 id)
            "longitude" : gdno(gatheringVO.position?.longtitude),
            "latitude" : gdno(gatheringVO.position?.latitude),
            ] as [String : Any]
        let params = [
            "meeting" :  meeting,
            "days" : sendDays,
            "position" :  position,
            "participant" : partinames,
            
            ] as [String : Any]
        
        Alamofire.request("\(baseURL)/room/create", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                     if let syncResult = data["result"].string{
                    if syncResult == "SUCCESS" {
                        self.view.networkResult(resultData: "동기화성공 완료되었습니다.", code: 1)
                       
                    }
                    else if syncResult == "FAIL" {
                   
                        self.view.networkResult(resultData: "동기화 실패하였습니다..", code: 0)
                    }

                }
                }
                break
            case .failure(let err) :
                print(err)
                print("방만들기실패\(err)")
                self.view.networkFailed()
            }
            
        }
        
    }
//    내방_상세보기에서 입력 버튼 눌렀을 때 기존에 입력했던 정보 제공 API
//    11번 통신
    func voteMyOpinion(my_meeting_id : Int){
        
        Alamofire.request("\(baseURL)/room/vote_my_opinion/\(my_meeting_id)").responseJSON()  { res in
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
                        
                        
                    }

                    var dateTempList = [String]()
                    if let dates = data["dates"].array{
                        for item in dates{
                            dateTempList.append(self.gsno(item.string))
                        }
                        
                    }
                    var selectedPosition = Position()
                        selectedPosition = Position(
                            place: self.gsno(data["position"]["place"].string),
                            longtitude:  self.gdno(Double(self.gsno(data["position"]["longitude"].string))),
                            latitude: self.gdno(Double(self.gsno(data["position"]["latitude"].string))))
                    
                    if let my_meeting_id = data["my_meeting_id"].int{
                        //나중에 저장해두고 필요할 때 보내주기만 하면 됨
                        // 약속관계 key
                        self.userDefault.set(my_meeting_id, forKey: "my_meeting_id")
                        
                        
                    }
                    let roomDetail = GatheringVO()
                    roomDetail.friend_list = tempList
                    roomDetail.days = dateTempList
                    roomDetail.position = selectedPosition
                    
                    self.view.networkResult(resultData: roomDetail, code: 0)
                }
                break
                
            case .failure(let err) :
                print(err)
                self.view.networkFailed()
            }
        }
    }
    
//    입력 버튼 눌러서 새로 입력한 정보 저장 API
//    12번 통신
    func voteMyOpinion_final(gatheringVO : GatheringVO){
        
        let id = userDefault.integer(forKey: "my_meeting_id")
    
        var partinames = [String]()
        var sendDays = [String]()
        var sendRoomInfo = RoomInfo()
        if let nparti = gatheringVO.participants{
            for parti in nparti{
                partinames.append(gsno(parti.name))
            }}
        if let nodays = gatheringVO.days{
            sendDays = nodays
        }
        let position = [
            "place" : gsno(gatheringVO.position?.place) ,//방장의 id(본인 id)
            "longitude" : gdno(gatheringVO.position?.longtitude),
            "latitude" : gdno(gatheringVO.position?.latitude),
            ] as [String : Any]
        let params = [
            "participant" :  partinames,
            "days" : sendDays,
            "position:" : position,
            "my_meeting_id" : id,

            ] as [String : Any]
        print(params)
        Alamofire.request("\(baseURL)/room/vote_my_opinion", method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    if let syncResult = data["result"].string{
                            if syncResult == "SUCCESS" {
                            // self.view.networkResult(resultData: "동기화성공 완료되었습니다.", code: 0)
                        }
                        else if syncResult == "FAIL" {
                            //  self.view.networkResult(resultData: "동기화 실패하였습니다..", code: 0)
                        }
                    }
                }
                break
            case .failure(let err) :
                print(err)
              
                self.view.networkFailed()
            }
            
        }
        
    }
    
}
