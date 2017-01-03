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


class PublicResult : UIViewController{
    
    var myGatheringList = [GatheringVO]()
    
    @IBOutlet var firstView : UIView!
    @IBOutlet var secondView : UIView!
    @IBOutlet var thirdView : UIView!
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var seg1Label : UILabel!
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 849, 0);
        self.scrollView.isScrollEnabled = true
        // self.scrollView.bounces = true
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        print(myGatheringList)
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
