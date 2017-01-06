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
    
    
    
    var ischecked = 0
    
    internal func networkResult(resultData: Any, code: Int) {
        if( code == 0 || code == 1){
            let alert = UIAlertController(title: "", message: "\(resultData)", preferredStyle: .alert)
            
            alert.addAction(self.btnOk)
            present(alert, animated: true , completion: nil)
        }
        if code == 1{
            ischecked = 1
        }
        else{
            ischecked = 0
        }
        
        if code == 2{
            let noldamTransitionDelegate = NoldamTrasitionDelegate()
            transitioningDelegate = noldamTransitionDelegate
            let pvc = storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
            pvc.modalPresentationStyle = .custom
            
            pvc.transitioningDelegate = noldamTransitionDelegate
            present(pvc, animated: true)
            
            
            //self.dismiss(animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
            // if let vc = presentingViewController as? SecondVC {
            //   vc.dismiss(animated: true,completion : nil)
            //}
        }
        
        
    }
    @IBAction func startEdit(_ sender: AnyObject) {
        keyboardWillShow()
        
    }
    @IBAction func endEdit(_ sender: AnyObject) {
        keyboardWillHide()
        
    }
    
    let btnOk = UIAlertAction(title: "확인", style: .default, handler: {_ in print("얍")})
    
    
    var IDdata = ""
    var PWdata = ""
    var Namedata = ""
    var Agedata = ""
    
    
    @IBAction func checkID(_ sender: AnyObject) {
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        model.checkID(id: id)
        
    }
    @IBOutlet var CompleteBtn: UIButton!
    
    @IBOutlet var imgContent: UIImageView!
    @IBOutlet var IdTextField: UITextField!
    @IBOutlet var PwTextField: UITextField!
    @IBOutlet var PwCheckText : UITextField!
    @IBOutlet var PhTextField : UITextField!
    @IBOutlet var liveTextfield : UITextField!
    @IBOutlet var workTextField : UITextField!
    @IBOutlet var nameTextField : UITextField!
    
    
    public var receivedinputIdData : String = ""
    public var receivedinputPasswdData : String = ""
    
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 포토 갤러리로 넘어가는거 구현
        hideKeyboardWhenTappedAround()//화면 누르면 키보드 내림
        picker.allowsEditing = true
        picker.delegate = self // 딜리게이트구현. 지금처럼 하지 말고 extension 이용해서 딜리게이트 상속받기
        
        imgContent.image = UIImage(named: "human_big")
        imgContent.roundedBorder()
        
        CompleteBtn.isEnabled = false
        CompleteBtn.setImage(UIImage(named: "joinoff"), for: UIControlState.normal)
        
        
    }
    @IBAction func selectPhoto(_ sender: AnyObject) {
        // 새로운 화면창을 띄운다
        // 10.0부터 사진첩 열 때 허락 받아야함 -> Info.plist 오른쪽클릭 -> open as -> source code한 뒤 <key>와 <string> 입력 (딕셔너리형태라고 생각하면 됨. 키와 밸류, 키와 밸류 ...)
        present(picker, animated: true)
    }
    
    @IBAction func ValueChanged(_ sender: AnyObject) {
        if((IdTextField.text?.characters.count != 0) && (PwTextField.text == PwCheckText.text) && (PwCheckText.text?.characters.count != 0) && (PhTextField.text?.characters.count != 0) && (ischecked==1)){
            CompleteBtn.isEnabled = true
            CompleteBtn.setImage(UIImage(named: "joinon"), for: UIControlState.normal)
            
            
        }
        else if(IdTextField.isEditing && (ischecked==1)){
            CompleteBtn.isEnabled = false
            CompleteBtn.setImage(UIImage(named: "joinoff"), for: UIControlState.normal)
            
            
        }
        else{
            CompleteBtn.isEnabled = false
            CompleteBtn.setImage(UIImage(named: "joinoff"), for: UIControlState.normal)
            
            
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
        
        let work = gsno(workTextField.text)
        let home = gsno(liveTextfield.text)
        
        
        
        let model = PostModel(self)
        let id = gsno(IdTextField.text)
        let pw = gsno(PwTextField.text)
        let ph = gsno(PhTextField.text)
        let name = gsno(nameTextField.text)
        if let image = imgContent.image{
            let imageData = UIImageJPEGRepresentation(image, 0.5) // (데이터로 바꿔준 이미지, 품질)
            model.joinWithPhoto(id: id, pw: pw, ph: ph, name: name,work : work, imageData: imageData,home: home)
        }
        
        
    }
    
    @IBAction func backBtn(_ sender: AnyObject){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func keyboardWillShow() {
        
       
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= 200
            }
        
    }
    
    func keyboardWillHide() {
  
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += 200
            }
    }
    
}

extension SecondVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // 이미지 선택하려다 취소했을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // 사진 선택 관련 딜리게이트
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("선택완료")
        // 새로운 이미지 프로퍼티를 만들어주고
        var newImage: UIImage
        
        //인자로 받은 info 딕셔너리 안에 만들어져 있는 거
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage{ // 크롭된 이미지
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 크롭 안 된 원본 이미지
            newImage = possibleImage
        } else {
            return
        }
        
        imgContent.image = newImage
        imgContent.roundedBorder()
        dismiss(animated: true, completion: nil) // present로 사진선택 들어왔기 때문에 dismiss 해주어야 함
    }
}
