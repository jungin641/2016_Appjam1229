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

    var childPageVC : UIViewController!
    var pageIndex:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(childPageVC)
        view.addSubview(childPageVC.view)
        
    
    }
    
}
