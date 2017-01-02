
//  ViewController.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//


import UIKit
import KCFloatingActionButton
import Contacts
//import DigitsKit

class MainVC: UITableViewController, NetworkCallback {
    
    var myGatheringList = [GatheringVO]()
    
    var contactList = [CNContact]()
    var friendList = [FriendVO]()
    override func viewDidLoad() {
        
        let model = PostModel(self)
        
        model.getPrivate()
        
        //+ 플로팅 버튼 생성
        let fab = KCFloatingActionButton()
        fab.paddingY = 70
        fab.sticky = true // sticking to parent UIScrollView(also UITableView, UICollectionView)
        
        let item = KCFloatingActionButtonItem()
        item.title = "공개방"
        item.handler = { item in
            self.moveScene(VCname: "NavMakeGatheringVC")
        }
        
        fab.addItem("비공개방", icon: UIImage(named: "icMap")) { item in
            self.moveScene(VCname: "NavMakeGatheringVC")
        }
        fab.addItem(item: item)
        
        
        self.view.addSubview(fab)
        
        
        
        getContacts()
        
    }
    func moveScene(VCname : String){
        if let vc = storyboard?.instantiateViewController(withIdentifier: VCname){
            present(vc, animated: true)
            
        }
    }
    
    internal func networkResult(resultData: Any, code: Int) {
        
        myGatheringList = resultData as! [GatheringVO]
        
        print("@@@@@@@@@")
        print(myGatheringList.count)
        
        tableView.reloadData()
        
    }
    override func networkFailed() {
        print("name dddd")
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGatheringList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "GatheringCell") as! GatheringCell
        let item = myGatheringList[indexPath.row]
        cell.imgProfile.image = UIImage(named : "ic_male")
        if let profileImg = item.profileImg {
            
            cell.imgProfile.imageFromUrl(profileImg, defaultImgPath: "ic_male")
            cell.imgProfile.contentMode = .scaleAspectFit
            cell.imgProfile.roundedBorder()
        }
        if let title = item.title {
            cell.txttitle.text = title
        }
        
        if let name = item.name {
            cell.txtname.text = name
            
        }
        if let place = item.where_fix {
            if(place == 0){
                cell.txtplace.text = "미정"
            }
            else if(place == 1){
                cell.txtplace.text = "확정"
            }
            
        }
        
        if let date = item.where_fix {
            if(date == 0){
                cell.txtdate.text = "미정"
            }
            else if(date == 1){
                cell.txtdate.text = "확정"
            }
            
        }
        if let participateNum = item.participateNum {
            cell.txtparticipateNum.text = "\(participateNum)명"
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //  //      let item = myGatheringList[indexPath.row]
    ////
    ////        let vc = storyboard?.instantiateViewController(withIdentifier: "PokemonInfoVC") as! PokemonInfoVC
    ////        vc.pokemon = item
    //
    ////        navigationController?.pushViewController(vc, animated: true)
    //
    //    }
    
    
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
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
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
            
            // model.sync(friends_list: friendList)
            
            
            
            
        } catch {
            print(error)
        }
        
        
    }
}

