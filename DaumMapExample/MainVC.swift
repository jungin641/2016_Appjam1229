
//  ViewController.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import KCFloatingActionButton
//import DigitsKit

class MainVC: UITableViewController, NetworkCallback {
    
    var myGatheringList = [GatheringVO]()
    
    override func viewDidLoad() {
        
        let model = PostModel(self)
      
        model.getPrivate()
        
        //+ 플로팅 버튼 생성
        let fab = KCFloatingActionButton()
        fab.paddingY = 70
        fab.sticky = true // sticking to parent UIScrollView(also UITableView, UICollectionView)
        
        let item = KCFloatingActionButtonItem()
        item.title = "직접 추가"
        item.handler = { item in
            self.moveScene(VCname: "NavMakeGatheringVC")
        }
        
        fab.addItem("기본옷 추가", icon: UIImage(named: "icMap")) { item in
            self.moveScene(VCname: "NavMakeGatheringVC")
        }
        fab.addItem(item: item)
        
        
        self.view.addSubview(fab)
        
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
        
        if let profileImg = item.profileImg {
            cell.imgProfile.image = UIImage(named: profileImg)
            cell.imgProfile.contentMode = .scaleAspectFit
            
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
    
    
}

