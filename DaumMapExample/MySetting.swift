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
        let imgValue = userDefault.string(forKey: "profile1")
        id?.text = stringValue
        name?.text = nameValue
        ph?.text = phValue
        home?.text = homeValue
        work?.text = workValue
        profile?.imageFromUrl(imgValue, defaultImgPath: "human_big")
        profile?.roundedBorder()
        
        print("$$$$$$$$$$$@!#@@!#@!#@!#")
        print(userDefault.string(forKey: "name"))
    }
    @IBAction func kakaoShare(_ sender: AnyObject) {
        let text = KakaoTalkLinkObject.createLabel("테스트입니다.")
        let image = KakaoTalkLinkObject.createImage("https://s3.ap-northeast-2.amazonaws.com/noldam/sitter/certificate/pokemon1.png", width: 164, height: 198)
        let appAction = KakaoTalkLinkAction.createAppAction(.IOS, devicetype: .phone, marketparamString: "itms-apps://itunes.apple.com/kr/app/noldam/id1137715307?mt=8", execparamString: "")!
        //        let appAction2 = KakaoTalkLinkAction.createApac
        //설치되어있으면 거기로 감 안되어있으면 아이튠즈 링크 뜸
        let link = KakaoTalkLinkObject.createAppButton("눌러보세요!!", actions: [appAction])
        KOAppCall.openKakaoTalkAppLink([text!, image!, link!])
    }
    
    @IBAction func editBtn(_ sender: Any) {
        
        
        let noldamTransitionDelegate = NoldamTrasitionDelegate()
        transitioningDelegate = noldamTransitionDelegate
        let pvc = storyboard!.instantiateViewController(withIdentifier: "EditPopupVC") as! EditPopupVC
        pvc.modalPresentationStyle = .custom
        
        pvc.transitioningDelegate = noldamTransitionDelegate
        present(pvc, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
