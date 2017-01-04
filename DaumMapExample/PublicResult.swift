//
//  publicResult.swift
//  DaumMapExample
//
//  Created by pro on 2016. 12. 31..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class PublicResult : UIViewController, NetworkCallback{
    
    var myGatheringList = [GatheringVO]()
    var friendList = [FriendVO]()
    var selectedArray = [FriendVO]()
    
    let maleImage = UIImage(named: "ic_male")
    let femaleImage  = UIImage(named: "ic_male_check")
    
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var tableView : UITableView!
    
    @IBAction func kakaoShare(_ sender: AnyObject) {
        let text = KakaoTalkLinkObject.createLabel("테스트입니다.")
        let image = KakaoTalkLinkObject.createImage("https://s3.ap-northeast-2.amazonaws.com/noldam/sitter/certificate/pokemon1.png", width: 164, height: 198)
        let appAction = KakaoTalkLinkAction.createAppAction(.IOS, devicetype: .phone, marketparamString: "itms-apps://itunes.apple.com/kr/app/noldam/id1137715307?mt=8", execparamString: "")!
        //        let appAction2 = KakaoTalkLinkAction.createApac
        //설치되어있으면 거기로 감 안되어있으면 아이튠즈 링크 뜸
        let link = KakaoTalkLinkObject.createAppButton("눌러보세요!!", actions: [appAction])
        KOAppCall.openKakaoTalkAppLink([text!, image!, link!])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        
//        let model = MakeGatheringModel(self)
//        model.getFriendsList()
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        print(myGatheringList)
    }
    internal func networkResult(resultData: Any, code: Int) {
        
        friendList = resultData as! [FriendVO]
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func btn1click(){
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        
    }
    @IBAction func btn2click(){
        firstView.isHidden = true
        secondView.isHidden = false
        thirdView.isHidden = true
        
    }
    @IBAction func btn3click(){
        firstView.isHidden = true
        secondView.isHidden = true
        thirdView.isHidden = false
        
    }
}

extension PublicResult: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        let item = friendList[indexPath.row]
        if let profile = item.profile {
            if let url = URL(string: profile){
                cell.imgProfile.kf.setImage(with: url)
                cell.imgProfile.contentMode = .scaleAspectFit
                
            }
        }
        if let name = item.name{
            cell.txtname.text = name
        }
        
        if let id = item.id {
            cell.email.text = id
        }
        
        
//        cell.checkBox.temp = gsno(item.id)
//        
//        if selectedArray.contains(where: gsno(item.id)){
//            cell.checkBox.setBackgroundImage(maleImage, for: UIControlState.normal)
//        }else{
//            cell.checkBox.setBackgroundImage(femaleImage, for: UIControlState.normal)
//        }
        return cell
    }
}
