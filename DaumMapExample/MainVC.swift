
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
        
        fab.addItem("비공개방", icon: UIImage(named: "pikachu128.jpg")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            fab.close()
        })
        fab.addItem("공개방", icon: UIImage(named: "pikachu128.jpg")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            fab.close()
        })
        self.view.addSubview(fab)
        
        
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
        
        
        cell.imgProfile.image = UIImage(named: gsno(item.profileImg))
        cell.imgProfile.contentMode = .scaleAspectFit
        
        
        
        cell.txttitle.text = item.title!
        
        
        
        cell.txtname.text = item.name!
        
        
        
        // cell.txtplace.text = item.place
        
        
        
        //cell.txtdate.text = item.date
        
        
        
        cell.txtparticipateNum.text = "\(item.participateNum!)명"
        
        
        
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

