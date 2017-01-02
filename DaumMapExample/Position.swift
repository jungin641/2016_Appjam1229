//
//  Position.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 1..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

class Position {
    var place : String?
    var longtitude : String?
    var latitude : String?
    
    init(){
        
    }
    
    init(place : String?, longtitude : String?, latitude : String?){
        self.place = place
        self.longtitude = longtitude
        self.latitude = latitude
    }
}
