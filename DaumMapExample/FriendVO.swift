//
//  FriendVO.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 1..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

class FriendVO{
    var name : String?
    var profile : String?
    var id : String?
    var ph : String?
    init(){
        
    }
    
    init(name : String, profile : String, id : String){
        self.name = name
        self.profile = profile
        self.id = id
    }
    init(name : String, ph : String){
        self.name = name
        self.ph = ph

    }
}
////ex
//friends_list: [
//{ name : 종식 profile : null id : whdtlr } ,
//{ name : 정민 profile: null id: wjdals }
//]
