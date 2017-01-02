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
    override func viewDidLoad() {
        super.viewDidLoad()
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 400, 0);
        
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
    }
    
    
    @IBAction func segementAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.isHidden = false
            secondView.isHidden = true
            thirdView.isHidden = true
          
        }
        
        
        else if sender.selectedSegmentIndex == 1 {
            
            firstView.isHidden = true
            secondView.isHidden = false
            thirdView.isHidden = true
            
         
        }
        else
        {
            firstView.isHidden = true
            secondView.isHidden = true
            thirdView.isHidden = false
           
        }
    }

    
}
