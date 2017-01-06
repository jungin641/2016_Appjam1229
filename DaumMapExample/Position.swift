//
//  Position.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 1..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

class Position {
    var place : String?
    var longtitude : Double?
    var latitude : Double?
    
    init(){
        
    }
    
    init(place : String?, longtitude : Double?, latitude : Double?){
        self.place = place
        self.longtitude = longtitude
        self.latitude = latitude
    }
}
