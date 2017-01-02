//
//  UserVO.swift
//  Huddle
//
//  Created by YuJungin on 2016. 12. 31..
//  Copyright © 2016년 JunginYu. All rights reserved.
//

class UserVO{
    //필수항목
    var id : String?
    var pw : String?
    var ph : String?
    var name: String?
    
    var profile : String?
    var home : String?
    var work: String?
    
    
    
    init(){ //디폴트 생성자
        
    }
  
    //회원가입시 쓰는 선택항목 all
    init(id: String?, pw:String?, ph: String?,name : String,work : String?,profile : String?,home : String){
        self.id = id
        self.pw = pw
        self.ph = name
        self.name = name
        self.home = home
        self.work = work
        self.profile = profile
    }

    
//    id : "jongsik"
//    ph : "01051487818"
//    name : "원종식"
//    profile : “img_url”
//    home : "경기도 고양시 일산서구 주엽2동 문촌마을 507동"
//    work : “숭실대 어디어디어디”
}
