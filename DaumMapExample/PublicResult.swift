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
