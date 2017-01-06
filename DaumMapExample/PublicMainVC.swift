//
//  ViewController.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import KCFloatingActionButton
import SwiftyJSON
import Alamofire

class PublicMainVC: UITableViewController , UISearchResultsUpdating ,NetworkCallback{
    
    var myGatheringList = [GatheringVO]()
    
    
    internal func networkResult(resultData: Any, code: Int) {
        
        myGatheringList = resultData as! [GatheringVO]
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let model = PostModel(self)
        
        model.getPrivate()
        
        //+ 플로팅 버튼 생성
        let fab = KCFloatingActionButton()
        fab.paddingY = 70
        fab.sticky = true // sticking to parent UIScrollView(also UITableView, UICollectionView)
        
        
        let item = KCFloatingActionButtonItem()
        let item1 = KCFloatingActionButtonItem()
        
        item.title = "공개방"
        item.buttonColor = UIColor(hex: 0xf0144b, alpha: 1.0)
        item.size = 10.0
        item.icon = UIImage(named: "openroom")
        item.handler = { item in
            self.moveScene(VCname: "NavMakeGatheringVC")
            
        }
        
        item1.title = "비공개방"
        item1.buttonColor = UIColor(hex: 0xf0144b, alpha: 1.0)
        item1.icon = UIImage(named: "noopenroom")
        item1.handler = { item1 in
            self.moveScene(VCname: "NavMakeGatheringVC")
            
        }
        
        
        fab.addItem(item: item)
        fab.addItem(item: item1)
        fab.buttonImage = UIImage(named:"pulus")

        
        self.view.addSubview(fab)
        
        
    }
    func moveScene(VCname : String){
        if let vc = storyboard?.instantiateViewController(withIdentifier: VCname){
            present(vc, animated: true)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let model = PostModel(self)
        
        model.getPrivate()
        
    }
    
    
    //검색창에 사용자가 입력할 때마다 위의 메소드 실행
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGatheringList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "GatheringCell") as! GatheringCell
        let item = myGatheringList[indexPath.row]
        
        cell.imgProfile.image = UIImage(named : "ic_male")
        if let profileImg = item.profileImg {
            
            cell.imgProfile.imageFromUrl(profileImg, defaultImgPath: "ic_male")
            cell.imgProfile.contentMode = .scaleAspectFit
            cell.imgProfile.roundedBorder()
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
        //
    }
    
    
}

