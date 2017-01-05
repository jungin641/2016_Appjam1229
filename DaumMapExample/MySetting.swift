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
import Contacts

class MySetting : UIViewController  ,NetworkCallback{
    
    @IBOutlet var id : UILabel?
    @IBOutlet var name : UILabel?
    @IBOutlet var ph : UILabel?
    @IBOutlet var home : UILabel?
    @IBOutlet var work : UILabel?
    
    var contactList = [CNContact]()
    var friendList = [FriendVO]()
    
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
    
    internal func networkResult(resultData: Any, code: Int) {
        
               
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
        
        
        let pvc = storyboard!.instantiateViewController(withIdentifier: "EditPopupVC") as! EditPopupVC
        pvc.modalPresentationStyle = .custom
        
      
        present(pvc, animated: true)
    }
    
    
    //연락처 정보 가져오는 메소드
    func getContacts() {
        let store = CNContactStore()
        
        //현재 디바이스에서 해당 앱이 연락처에 접근하는걸 승인했는지 아닌지 체크하는 메소드
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            retrieveContactsWithStore(store)
        }
    }
    
    //디바이스에 저장된 연락처를 가져와 [CNContact] 배열에 저장하는 메소드
    func retrieveContactsWithStore(_ store: CNContactStore) {
        do {
            let contactIDs = try store.defaultContainerIdentifier()
            
            let predicate = CNContact.predicateForContactsInContainer(withIdentifier: contactIDs)
            
            //각각의 정보마다(전화번호, 이메일, 이름 등) 고유키가 있고 이 키를 지정해주지 않으면 해당 정보를 가져올 수 없다. 여기서는 전화번호를 가져오기 위해 CNContactPhoneNumbersKey를 사용
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            contactList = contacts
            
            for item in contactList {
                
                let formatter = CNContactFormatter()
                
                let friendname = formatter.string(from: item)
                let number = item.phoneNumbers.first?.value
                let minusSlash = number?.stringValue.replacingOccurrences(of: "-", with: "")
                let minusLeft = minusSlash?.replacingOccurrences(of: "(", with: "")
                let minusRight = minusLeft?.replacingOccurrences(of: ")", with: "")
                let minusGongBack = minusRight?.replacingOccurrences(of: " ", with: "")
                let minusSlash2 = minusGongBack?.replacingOccurrences(of: "/", with: "")
                let minusKorean = minusSlash2?.replacingOccurrences(of: "+82", with: "")
                
                friendList.append(FriendVO(name: gsno(friendname), ph: gsno(minusKorean)))
                
            }
            
            let model = PostModel(self)
            print("연락처동기화연락처동기화연락처동기화연락처동기화연락처동기화연락처동기화")
            
            model.sync(friends_list: friendList)
            
            
            
            
        } catch {
            print(error)
        }
        
        
    }

    
    
    
    
    
    
    
    
    
    
}
