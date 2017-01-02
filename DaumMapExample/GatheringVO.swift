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
    var participant : [String]?
    var days : [String]?
    var position : Position?
    
    init(){ //디폴트 생성자
        
    }
    //메인페이지용 생성자
    init(profileImg: String?, title:String?, name: String?,where_fix : Int? ,when_fix : Int?,participateNum : Int?){
        self.profileImg = profileImg
        self.title = title
        self.name = name
        self.where_fix = where_fix
        self.when_fix = when_fix
        self.participateNum = participateNum
    }
    //만들기/편집용 생성자
    init(participant : [String]?,days : [String]?,position : Position?){
        self.participant = participant
        self.days = days
        self.position = position
    }
    
    //상세보기용 생성자
//    init(profileImg: String?, title:String?, name: String?,where_fix : Int? ,when_fix : Int?,participateNum : Int?){
//        self.profileImg = profileImg
//        self.title = title
//        self.name = name
//        self.where_fix = where_fix
//        self.when_fix = when_fix
//        self.participateNum = participateNum
//    }
}
//방 만들기 완료 버튼 누를 때 ( 방 정보 다 선택하고 최종적으로 완료 버튼 누를 때)
//meeting : {
//    host_id : string
//    title : string
//    text : string
//    is_open : int (0: 비공개방, 1: 공개방)
//    when_fix : int (0:날짜 미정, 1: 날짜 확정)
//    where_fix : int ( 0: 장소 미정, 1: 장소 확정)
//}
//days : [ string ] //방장이 가능한 날짜를 표시함.
//position { //방장이 가능한 위치를 표시함
//    place : string
//    longtitude : string
//    latitude : string
//}
//participant : [ string ] //참여자 id

//meeting : {
//    host_id : string
//    title : string
//    text : string
//    is_open : int (0: 비공개방, 1: 공개방)
//    when_fix : int (0:날짜 미정, 1: 날짜 확정)
//    where_fix : int ( 0: 장소 미정, 1: 장소 확정)
//}
