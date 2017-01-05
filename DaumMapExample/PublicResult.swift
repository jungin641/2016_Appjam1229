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


class PublicResult : UIViewController, NetworkCallback {
    
    var roomInfo = GatheringVO()
    var friendList = [FriendVO]()
    var selectedArray = [FriendVO]()
    
    var meeting_id : Int?
    
    let maleImage = UIImage(named: "ic_male")
    let femaleImage  = UIImage(named: "ic_male_check")
    let picker = UIImagePickerController()
    
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var roomImage : UIImageView!
    @IBOutlet var hostprofileImage : UIImageView!
    @IBOutlet var hostname : UILabel!
    @IBOutlet var roomTitle : UILabel!
    @IBOutlet var roomContent : UILabel!
    
    internal func networkResult(resultData: Any, code: Int) {
        if let thisRoomInfo = resultData as? GatheringVO{
            roomInfo = thisRoomInfo
            print("networkResultnetworkResultnetworkResultnetworkResult")
           
        }
        if let prc = childViewControllers[1] as? PublicResultCalendarVC {
            prc.selectedDates =  roomInfo.dates!
            prc.selectView()
            
        }
        
        if let pmc = childViewControllers[0] as? PublicMapVC {
            
            for p in roomInfo.participants!{
                pmc.selectedPosition?.append(Position(place: p.place, longtitude: p.longitude, latitude: p.latitude))
               
            }
             pmc.putPoiItem()
        }
      
        
    }
    
    
    
    @IBAction func selectPhoto(_ sender: AnyObject) {
        // 새로운 화면창을 띄운다
        // 10.0부터 사진첩 열 때 허락 받아야함 -> Info.plist 오른쪽클릭 -> open as -> source code한 뒤 <key>와 <string> 입력 (딕셔너리형태라고 생각하면 됨. 키와 밸류, 키와 밸류 ...)
        present(picker, animated: true)
    }
    
    @IBAction func CompleteBtn(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = MakeGatheringModel(self)
        
        model.roomDetail(meeting_id: gino(meeting_id))
        
        picker.allowsEditing = true
        picker.delegate = self // 딜리게이트구현. 지금처럼 하지 말고 extension 이용해서 딜리게이트 상속받기
        
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        firstView.reloadInputViews()
        reloadInputViews()
        
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PRFriendCell") as! PRFriendCell
        
        //        if let name = item.name{
        //            cell.txtname.text = name
        //        }
        //
        //        if let id = item.id {
        //            cell.email.text = id
        //        }
        //
        //
        //        cell.checkBox.temp = gsno(item.id)
        
        //        if selectedArray.contains(where: gsno(item.id)){
        //            cell.checkBox.setBackgroundImage(maleImage, for: UIControlState.normal)
        //        }else{
        //            cell.checkBox.setBackgroundImage(femaleImage, for: UIControlState.normal)
        //        }
        return cell
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
}

extension PublicResult: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // 이미지 선택하려다 취소했을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // 사진 선택 관련 딜리게이트
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("선택완료")
        // 새로운 이미지 프로퍼티를 만들어주고
        var newImage: UIImage
        
        //인자로 받은 info 딕셔너리 안에 만들어져 있는 거
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage{ // 크롭된 이미지
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 크롭 안 된 원본 이미지
            newImage = possibleImage
        } else {
            return
        }
        
        hostprofileImage.image = newImage
        hostprofileImage.roundedBorder()
        dismiss(animated: true, completion: nil) // present로 사진선택 들어왔기 때문에 dismiss 해주어야 함
    }
}
