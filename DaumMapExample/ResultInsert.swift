//
//  ResultInsert.swift
//  Huddle
//
//  Created by YuJungin on 2017. 1. 6..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit

class ResultInsert: UIViewController, NetworkCallback {
    var userdefault = UserDefaults.standard
    var prRoomInfo = GatheringVO()
    var friendList = [FriendVO]()
    var selectedArray = NSMutableArray()

    var meeting_id : Int?
    
    let maleImage = UIImage(named: "vv")
    let femaleImage  = UIImage(named: "v")
    
    
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var tableView : UITableView!
    internal func networkResult(resultData: Any, code: Int) {
//        roomDetail.friend_list = tempList
//        roomDetail.days = dateTempList
//        roomDetail.position = selectedPosition
        
        
       let insertedData = resultData as! GatheringVO
        
        friendList = insertedData.friend_list
        prRoomInfo.days = insertedData.days
        prRoomInfo.position = insertedData.position
        
 
        if let prc = childViewControllers[1] as? ResultInsertCalendarVC {
            prc.selectedDatesDate =  prRoomInfo.days!
            prc.selectView()
            
        }
        
        if let pmc = childViewControllers[0] as? ResultInsertMapVC {
            
            pmc.selectedPosition = [Position]()
            if let prRoomInfoparti  = prRoomInfo.participants{
            for p in prRoomInfoparti{
                pmc.selectedPosition?.append(Position(place: p.place, longtitude: p.longitude, latitude: p.latitude))
                
            }
            }
            pmc.putPoiItem()
        }
        
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = MakeGatheringModel(self)
        meeting_id = userdefault.integer(forKey: "my_meeting_id")
        model.voteMyOpinion(my_meeting_id: gino(meeting_id))
        
        
        
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
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsertFriendCell") as! InsertFriendCell
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
        
        
        cell.checkBox.temp = gino(item.id)
        cell.checkBox.addTarget(self, action: #selector(ContactsViewController.tickClicked(sender:)), for: .touchUpInside)
        if selectedArray.contains(gino(item.id)){
            cell.checkBox.setBackgroundImage(maleImage, for: UIControlState.normal)
        }else{
            cell.checkBox.setBackgroundImage(femaleImage, for: UIControlState.normal)
        }
        return cell
    }
    
    
    func tickClicked(sender: CheckBox!){
        let value = sender.temp
        if selectedArray.contains(value){
            selectedArray.remove(value)
        }else{
            selectedArray.add(value)
        }
        
        tableView.reloadData()
        
    }
    
}
