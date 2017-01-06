//
//  Participants.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 4..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

class Participants {
    var name : String? //참여자 이름
    var is_input : String? //참여자 입력 여부 “1”입력 “0” 미입력
    var place : String? //참여자가 입력한 한글주소명
    var longitude : Double? //해당 주소의 위도
    var latitude : Double? //해당 주소의 경도
    
    init(){
    }
    
    init(name : String?, is_input : String?, place : String?, longitude : Double?, latitude : Double?){
        self.name = name
        self.is_input = is_input
        self.place = place
        self.longitude = longitude
        self.latitude = latitude
        
    }
    
    
}
