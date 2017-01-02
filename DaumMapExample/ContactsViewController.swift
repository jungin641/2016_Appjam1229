
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
       // tableView.setEditing(true, animated: <#T##Bool#>)
        model.getFriendsList()
        self.tableView.reloadData()
        
    }
    internal func networkResult(resultData: Any, code: Int) {
        
        friendList = resultData as! [FriendVO]
        print(friendList.count)
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
            print("id출력")
            print(id)
        }
        
//      //  cell.checkBox.addTarget(self, action:#selector(ViewController.tickClicked(_:)), forControlEvents: .TouchUpInside)
//        cell.checkBox.addTarget(self, action: #selector(ViewController.tickClicked(), for: .touchUpInside)
//        
//        cell.checkBox.tag=indexPath.row
//        
//        if selectedArray .containsObject(numberArray.objectAtIndex(indexPath.row)) {
//            cell.checkBox.setBackgroundImage(UIImage(named:"Select.png"), forState: UIControlState.Normal)
//        }
//        else
//        {
//            cell.checkBox.setBackgroundImage(UIImage(named:"Diselect.png"), forState: UIControlState.Normal)
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
//    func tickClicked(sender: UIButton!)
//    {
//        let value = sender.tag;
//        
//        if selectedArray.containsObject(friendList.objectAtIndex(value))
//        {
//            selectedArray.removeObject(friendList.objectAtIndex(value))
//        }
//        else
//        {
//            selectedArray.addObject(numberArray.objectAtIndex(value))
//        }
//        
//        print("Selecetd Array \(selectedArray)")
//        
//        objTable.reloadData()
//        
//    }
    
}

