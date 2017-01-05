//
//  RoomInfo.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 4..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

class RoomInfo{
    var title : String? //방의 제목
    var text : String? //방의 내용
    var is_open : Int?// (0: 비공개방, 1: 공개방)
    var when_fix : Int? //(0:날짜 미정, 1: 날짜 확정)
    var where_fix : Int?// ( 0: 장소 미정, 1: 장소 확정)
    var room_image : String? //방의 사진 URL
    var host : String? //호스트의 이름
    var hostprofile : String? //호스트 사지 ㄴURL
    
    init(){
        
    }
    init(title : String?, text : String?,is_open : Int?,when_fix : Int?,where_fix : Int?, room_image : String?, host : String?,hostprofile : String?){
        self.title = title
        self.text = text
        self.is_open = is_open
        self.when_fix = when_fix
        self.where_fix = where_fix
        self.room_image = room_image
        self.host = host
        self.hostprofile = hostprofile
    }
}
