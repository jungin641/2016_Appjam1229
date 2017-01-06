//
//  ResultInsert.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 6..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit

class ResultInsert: UIViewController, NetworkCallback {
    var prRoomInfo = GatheringVO()
    var friendsParticipate = [Participants]()
    var selectedArray = [Participants]()
    
    var meeting_id : Int?
    
    let checked = UIImage(named: "checkbox")
    let nochecked  = UIImage(named: "nochecked")
    
    let picker = UIImagePickerController()

    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var tableView : UITableView!
    internal func networkResult(resultData: Any, code: Int) {
        if let thisRoomInfo = resultData as? GatheringVO{
            prRoomInfo = thisRoomInfo
            
        }
        if let prc = childViewControllers[1] as? PublicResultCalendarVC {
            prc.selectedDates =  prRoomInfo.dates!
            prc.selectView()
            
        }
        
        if let pmc = childViewControllers[0] as? PublicMapVC {
            
            pmc.selectedPosition = [Position]()
            for p in prRoomInfo.participants!{
                pmc.selectedPosition?.append(Position(place: p.place, longtitude: p.longitude, latitude: p.latitude))
                
            }
            
            pmc.putPoiItem()
        }
        
                for p in prRoomInfo.participants!{
            friendsParticipate.append(p)
        }
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = MakeGatheringModel(self)
        
        model.roomDetail(meeting_id: gino(meeting_id))
        
        
        
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        firstView.reloadInputViews()
        reloadInputViews()
        
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
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


extension ResultInsert: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsParticipate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsertFriendCell") as! FriendCell
        
        
        
        
        let item = friendsParticipate[indexPath.row]
        
        if let name = item.name{
            cell.txtname.text = name
        }
        
        
        for p in friendsParticipate{
            if p.is_input == "1" {
                cell.checkBox.setBackgroundImage(checked, for: UIControlState.normal)
            }
            else if p.is_input == "0"{
                cell.checkBox.setBackgroundImage(nochecked, for: UIControlState.normal)
                
            }
            
        }
        
        return cell
    }
   
    
    
}
