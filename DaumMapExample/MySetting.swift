//
//  MySettingVC.swift
//  Huddle
//
//  Created by pro on 2017. 1. 2..
//  Copyright © 2017년 JunginYu. All rights reserved.
//   1.2. 수정

import UIKit
import Alamofire
import SwiftyJSON

class MySetting : UIViewController{
    
    @IBOutlet var id : UILabel?
    @IBOutlet var name : UILabel?
    @IBOutlet var ph : UILabel?
    @IBOutlet var home : UILabel?
    @IBOutlet var work : UILabel?
    
    @IBOutlet var profile : UIImageView?
    override func viewDidLoad() {
        
        let userDefault = UserDefaults.standard
        let stringValue = userDefault.string(forKey: "id")
        let nameValue = userDefault.string(forKey: "name")
        let phValue = userDefault.string(forKey: "ph")
        let homeValue = userDefault.string(forKey: "home")
        let workValue = userDefault.string(forKey: "work")
        let imgValue = userDefault.string(forKey: "profile")
        id?.text = stringValue
        name?.text = nameValue
        ph?.text = phValue
        home?.text = homeValue
        work?.text = workValue
        profile?.imageFromUrl(imgValue, defaultImgPath: "human_big")
        profile?.roundedBorder()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
