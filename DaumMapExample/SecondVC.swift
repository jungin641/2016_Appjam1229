//
//  SecondVC.swift
//  seminar_2_hw
//
//  Created by YuJungin on 2016. 10. 23..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SecondVC : UIViewController, NetworkCallback {
    internal func networkResult(resultData: Any, code: Int) {
        
        
        let alert = UIAlertController(title: "", message: "\(resultData)", preferredStyle: .alert)
        
        alert.addAction(btnOk)
        present(alert, animated: true , completion: nil)
    }

    let btnOk = UIAlertAction(title: "확인", style: .default, handler: {_ in print("얍")})

    let maleImage = UIImage(named: "ic_male")
    let femaleImage  = UIImage(named: "ic_female")
    let maleImageClicked = UIImage(named: "ic_male_check")
    let femaleImageClicked  = UIImage(named: "ic_female_check")
  
    var IDdata = ""
    var PWdata = ""
    var Namedata = ""
    var Agedata = ""
    var IsWoman = true
    
    @IBAction func checkID(_ sender: AnyObject) {
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        model.checkID(id: id)
        
    }
    @IBOutlet var CompleteBtn: UIButton!

    
    @IBOutlet var IdTextField: UITextField!
    @IBOutlet var PwTextField: UITextField!
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var AgeTextField: UITextField!
    
    @IBOutlet var maleImageToggleBtn: ToggleImageBtn!
    @IBOutlet var femaleImageToggleBtn: ToggleImageBtn!

    public var receivedinputIdData : String = ""
    public var receivedinputPasswdData : String = ""

   
    override func viewDidLoad() {
        super.viewDidLoad()

        maleImageToggleBtn.setBackgroundImage(maleImageClicked, for: UIControlState())
        maleImageToggleBtn.setBtnClickedImg(clickedImage: maleImageClicked!)
        maleImageToggleBtn.setBtnUnClickedImg(unClickedImage: maleImage!)
        
        femaleImageToggleBtn.setBackgroundImage(femaleImageClicked, for: UIControlState())
        femaleImageToggleBtn.setBtnClickedImg(clickedImage: femaleImageClicked!)
        femaleImageToggleBtn.setBtnUnClickedImg(unClickedImage: femaleImage!)
        
        CompleteBtn.isEnabled = false
        CompleteBtn.backgroundColor = UIColor( red :177/255 , green : 181/255, blue : 192/255, alpha : 1)
        

           }
    
    @IBAction func ValueChanged(_ sender: AnyObject) {
        if((IdTextField.text?.characters.count != 0) && (PwTextField.text?.characters.count != 0) && (NameTextField.text?.characters.count != 0) && (AgeTextField.text?.characters.count != 0) ){
            CompleteBtn.isEnabled = true
            CompleteBtn.backgroundColor = UIColor( red :238/255 , green : 203/255, blue : 44/255, alpha : 1)
            
        }
        else{
            CompleteBtn.isEnabled = false
            CompleteBtn.backgroundColor = UIColor( red :177/255 , green : 181/255, blue : 192/255, alpha : 1)
        }
        
    }
    func IsTextFieldEmpty(TextfieldCharacterCount : Int) -> Bool {
        
        if(TextfieldCharacterCount>0){
            return false
        }
        else{
            return true
        }
        
    }
    @IBAction func FCompleteBtn(_ sender: AnyObject) {
        
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        let pw = gsno(PwTextField.text)
        let ph = gsno(NameTextField.text)
        let name = gsno(AgeTextField.text)
        
        model.join(id: id, pw: pw, ph: ph, name: name)
 
            
//            
//            let noldamTransitionDelegate = NoldamTrasitionDelegate()
//            transitioningDelegate = noldamTransitionDelegate
//            let pvc = storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
//            pvc.modalPresentationStyle = .custom
//            pvc.strDate = id
//            pvc.transitioningDelegate = noldamTransitionDelegate
//            present(pvc, animated: true)
    }
        
        


        
        
    
    func IsFemale(){
        if(maleImageToggleBtn.Btnstate == 1 && femaleImageToggleBtn.Btnstate == 0){
            IsWoman = true}
        else if (maleImageToggleBtn.Btnstate == 0 && femaleImageToggleBtn.Btnstate == 1){
            IsWoman = false}
    }
}
