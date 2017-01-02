
//  ViewController.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//


import UIKit

class ContactsViewController: UITableViewController, NetworkCallback {
    
    var friendList = [FriendVO]()
    var selectedArray = NSMutableArray()
    
    let maleImage = UIImage(named: "ic_male")
    let femaleImage  = UIImage(named: "ic_male_check")
    
    override func viewDidLoad() {
        
        let model = MakeGatheringModel(self)
        model.getFriendsList()
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    internal func networkResult(resultData: Any, code: Int) {
        
        friendList = resultData as! [FriendVO]
        print(friendList.count)
        tableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

        
        cell.checkBox.temp = gsno(item.id)
        cell.checkBox.addTarget(self, action: #selector(ContactsViewController.tickClicked(sender:)), for: .touchUpInside)
        if selectedArray.contains(gsno(item.id)){
            cell.checkBox.setBackgroundImage(maleImage, for: UIControlState.normal)
        }else{
            cell.checkBox.setBackgroundImage(femaleImage, for: UIControlState.normal)
        }
                return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("!!!!!!!참여자id출력!!!!!!")
        print(selectedArray.count)
        print(selectedArray)
    }
    
    
    func tickClicked(sender: CheckBox!){
        let value = sender.temp
        if selectedArray.contains(value){
            selectedArray.remove(value)
        }else{
            selectedArray.add(value)
        }
        tableView.reloadData()
        
        if let parentVC = self.parent?.parent as? MakeGatheringVC {
            print("ok")
            let newGathering = parentVC.newGathering
            if let swiftArray = selectedArray as NSArray as? [String] {
                newGathering.setParticipant(participant: swiftArray)
            }
            
        }
        else{
            print("error")
        }

    }
    
    
}

