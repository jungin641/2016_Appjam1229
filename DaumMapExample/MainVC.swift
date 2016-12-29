//
//  ViewController.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import KCFloatingActionButton
//import DigitsKit

class MainVC: UITableViewController {

    var myGatheringList = [Gathering]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //+ 플로팅 버튼 생성
        let fab = KCFloatingActionButton()
        fab.paddingY = 70
        fab.sticky = true // sticking to parent UIScrollView(also UITableView, UICollectionView)
        
        fab.addItem("I got a handler", icon: UIImage(named: "pikachu128.jpg")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            fab.close()
        })
        self.view.addSubview(fab)
        
         myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
        myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
        myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
        myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
         myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
         myGatheringList.append(Gathering(profileImg: "pikachu128", title: "종주랑 초밥", names: ["종주","나"],place : "상수역 2번출구" ,date : "12월 29일",wholeParticipateNum : 8 ,confirmNum : 6, participateNum : 3))
        
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
        
        if let names = item.names {
            var namesforArray : String?
            for element in names {
                namesforArray?.append("\(element), ")
            }
            cell.txtnames.text = namesforArray
            
        }
        if let place = item.place {
            cell.txtplace.text = place
        }
        
        if let date = item.date {
            cell.txtdate.text = date
            
        }
       
            cell.txtconfirmNum.text = "\(item.personNumDict["wholeParticipateNum"]!)명 중\(item.personNumDict["confirmNum"]!)명 확인"
            cell.txtparticipateNum.text = "\(item.personNumDict["confirmNum"]!)명 중\(item.personNumDict["participateNum"]!)명 참석"
      
        
        
        return cell
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

