//
//  makeRoomResult.swift
//  Huddle
//
//  Created by pro on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit



class MakeRoomResult : UIViewController, MTMapViewDelegate{
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var btn1 : UIButton?
    @IBOutlet var btn2 : UIButton?
    
    var ischeck1 = 0
    var ischeck2 = 0
    override func viewDidLoad() {
        //super.viewDidLoad()
//        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 250, 0);
//        self.scrollView.isScrollEnabled = true
//        
//     btn1?.setImage(UIImage(named:"pikachu"), for: UIControlState.normal)
//        
        
        
    
    }
    
    
    
    
    @IBAction func isConfirm1(_ sender: Any) {
        ischeck1 += 1
        if (ischeck1 % 2) == 1{
            btn1?.setImage(UIImage(named:"info_box_tail"), for: UIControlState.normal)
        }
        else{
            btn1?.setImage(UIImage(named:"pikachu128"), for: UIControlState.normal)
        }
    }
    
    @IBAction func isConfirm2(_ sender: Any) {
        
        ischeck2 += 1
        if (ischeck2 % 2) == 1{
            btn1?.setImage(UIImage(named:"info_box_tail"), for: UIControlState.normal)
        }
        else{
            btn1?.setImage(UIImage(named:"pikachu128"), for: UIControlState.normal)
        }

    }
    
    
    
    
    
    
}
