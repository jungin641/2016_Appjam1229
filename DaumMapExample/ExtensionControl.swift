//
//  ExtensionControl.swift
//  ContactList
//
//  Created by  noldam on 2016. 12. 29..
//  Copyright © 2016년 Pumpa. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    func gsno(_ value: String?) -> String {
        if let value_ = value {
            return value_
        } else {
            return ""
        }
    }
    
    func gino(_ value: Int?) -> Int {
        if let value_ = value {
            return value_
        } else {
            return 0
        }
    }
    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }

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
extension UIImageView {
    func roundedBorder() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
}
