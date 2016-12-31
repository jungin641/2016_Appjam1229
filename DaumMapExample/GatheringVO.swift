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
