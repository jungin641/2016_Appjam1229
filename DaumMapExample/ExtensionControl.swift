//
//  ExtensionControl.swift
//  ContactList
//
//  Created by  noldam on 2016. 12. 29..
//  Copyright © 2016년 Pumpa. All rights reserved.
//

import UIKit

extension String {
    var asPhoneFormat: String {
        if self.lengthOfBytes(using: String.Encoding.utf8) == 11 {
            
            let i1 = self.characters.index(self.startIndex, offsetBy: 3)
            let i2 = self.characters.index(self.startIndex, offsetBy: 7)
            let range = i1..<i2
            let p1 = self.substring(to: i1)
            let p2 = self.substring(with: range)
            let p3 = self.substring(from: i2)
            let txtPhone = "\(p1)-\(p2)-\(p3)"
            
            return txtPhone
        } else if self.lengthOfBytes(using: String.Encoding.utf8) == 10 {
            
            let i1 = self.characters.index(self.startIndex, offsetBy: 3)
            let i2 = self.characters.index(self.startIndex, offsetBy: 6)
            let range = i1..<i2
            let p1 = self.substring(to: i1)
            let p2 = self.substring(with: range)
            let p3 = self.substring(from: i2)
            let txtPhone = "\(p1)-\(p2)-\(p3)"
            
            return txtPhone
        } else {
            return self
        }
    }
}

extension UIViewController {
    
    //화면 클릭시 키보드 내리는 메소드
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //키보드 내리는 메소드
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
