//
//  ContentViewController.swift
//  pageSample
//
//  Created by woong on 2016. 3. 29..
//  Copyright © 2016년 handstudio. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!

    var pageIndex : Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(pageIndex == 0){
           if  let vc = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController"){
                addChildViewController(vc)
                view.addSubview(vc.view)
            }
        }else if(pageIndex == 1){
          if  let vc = storyboard?.instantiateViewController(withIdentifier: "CalendarVC"){
                addChildViewController(vc)
                view.addSubview(vc.view)
            }
        }else if(pageIndex == 2){
          if  let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController"){
                addChildViewController(vc)
                view.addSubview(vc.view)
            }
        }
    
    }
    
}
