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
    var place : String?
    var date : String?
    var participateNum: Int?
    
    
    
    init(){ //디폴트 생성자
        
    }
    init(profileImg: String?, title:String?, name: String?,place : String? ,date : String?,participateNum : Int?){
        self.profileImg = profileImg
        self.title = title
        self.name = name
        self.place = place
        self.date = date
        self.participateNum = participateNum
    }
    
}
