//
//  Gathering.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//

class GatheringVO{
    
    var profileImg : String?
    var title : String?
    var name: String?
    var when_fix : Int?
    var where_fix : Int?
    var participateNum: Int?
    var participant : [Int]?
    var days : [String]?
    var position : Position?
    var participants : [Participants]?
    var roomInfos : [RoomInfo]?
    var roomInfo : RoomInfo?
    var dates : [Dates]?
    var meeting_id : Int?
    var is_open : Int?
    var place : String?
    var longitude : String?
    var latitude : String?
    var friend_list = [FriendVO]()
    init(){ //디폴트 생성자
        
        
    }
    //메인페이지용 생성자
    init(profileImg: String?, title:String?, name: String?,where_fix : Int? ,when_fix : Int?,participateNum : Int?,meeting_id : Int?, is_open : Int?){
        self.profileImg = profileImg
        self.title = title
        self.name = name
        self.where_fix = where_fix
        self.when_fix = when_fix
        self.participateNum = participateNum
        self.meeting_id = meeting_id
        self.is_open = is_open
    }
    
    //내 방 상세보기용 생성자
    init(participants : [Participants]? , roomInfos : [RoomInfo]?, dates : [Dates]?){
        self.participants = participants
        self.roomInfos = roomInfos
        self.dates = dates
    }
    // 방 만들기용 참여자 반영
    func setParticipant(participant : [Int]?){
        self.participant = participant
    }
    // 방 만들기용 일자 선택
    func setDays(days : [String]){
        self.days = days
    }
    // 방 만들기용 위치 선택
    func setPosision(position : Position?){
        self.position = position
    }
    
    // 방에 참여했을때 정보받아오기 & 투표
    init(name : String? , profileImg : String?, place : String?, longitude : String?, latitude : String?, days : [String]?)
    {
        self.name = name
        self.profileImg = profileImg
        self.place = place
        self.longitude = longitude
        self.latitude = latitude
        self.days = days
        
    }
}
