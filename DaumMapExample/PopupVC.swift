//
//  PopupVC.swift
//  PopupSample
//
//  Created by  noldam on 2016. 12. 29..
//  Copyright © 2016년 Pumpa. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {
    
    
    
    @IBAction func exit(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
    }
    
    
}
