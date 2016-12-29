//
//  Gathering.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//

class Gathering{
    
    var profileImg : String?
    var title : String?
    var names : [String]?
    var place : String?
    var date : String?
    var personNumDict: [String:Int] = [
        "wholeParticipateNum" : 0,
        "confirmNum" : 0,
        "participateNum" : 0
    ]
    
    
    var wholeParticipateNum : Int?
    var confirmNum : Int?
    var participateNum : Int?
    
    init(){ //디폴트 생성자
        
    }
    init(profileImg: String?, title:String?, names: [String]?,place : String? ,date : String?,wholeParticipateNum : Int?,confirmNum : Int?,participateNum : Int?){
        self.profileImg = profileImg
        self.title = title
        self.names = names
        self.place = place
        self.date = date
        self.personNumDict["wholeParticipateNum"]  = wholeParticipateNum
        self.personNumDict["confirmNum"]  = confirmNum
        self.personNumDict["participateNum"] = participateNum
    }
    
}
