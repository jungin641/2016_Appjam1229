//
//  ViewController.swift
//  seminar_1_hw_2
//
//  Created by YuJungin on 2016. 10. 9..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController :UIViewController, NetworkCallback,UITextFieldDelegate {
    
    internal func networkResult(resultData: Any, code: Int) {
        let alert = UIAlertController(title: "", message: "\(resultData)", preferredStyle: .alert)
        
        alert.addAction(btnOk)
        //present(alert, animated: true , completion: nil)
        
        let i = resultData as! Int
        
        if(i == 1){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "UITabbar_custom"){
                
                present(vc, animated: true)
            }}
    }
    @IBAction func kakaoShare(_ sender: AnyObject) {
        let text = KakaoTalkLinkObject.createLabel("테스트입니다.")
        let image = KakaoTalkLinkObject.createImage("https://s3.ap-northeast-2.amazonaws.com/noldam/sitter/certificate/pokemon1.png", width: 164, height: 198)
        let appAction = KakaoTalkLinkAction.createAppAction(.IOS, devicetype: .phone, marketparamString: "itms-apps://itunes.apple.com/kr/app/noldam/id1137715307?mt=8", execparamString: "")!
//        let appAction2 = KakaoTalkLinkAction.createApac
        //설치되어있으면 거기로 감 안되어있으면 아이튠즈 링크 뜸
        let link = KakaoTalkLinkObject.createAppButton("눌러보세요!!", actions: [appAction])
        KOAppCall.openKakaoTalkAppLink([text!, image!, link!])
    }

    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPasswd: UITextField!
    let btnOk = UIAlertAction(title: "확인", style: .default, handler: {_ in print("얍")})

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do this for each UITextField
        txtID.delegate = self
        txtID.tag = 0 //Increment accordingly
        txtPasswd.delegate = self
        txtPasswd.tag = 1
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func BtnSignUp(_ sender: AnyObject) {
        if let svc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC{
            // 화면전환
            print("!!!!")
            navigationController?.pushViewController(svc, animated: true)
        }

    }
 
    @IBAction func BtnLogin(_ sender: AnyObject) {
        if(txtID.text == "" && (txtPasswd.text?.characters.count)! > 0){
            let alert = UIAlertController(title: "", message: "ID를 입력해 주세요", preferredStyle: .alert)
            //이렇게 일일히  계속 반복해주는것보다 extension(확장구문)을 사용하여 코드의 반복을 줄여주자.
            
            alert.addAction(btnOk)
            present(alert, animated: true , completion: nil)
        }
        else if (txtPasswd.text == "" && (txtID.text?.characters.count)! > 0){
            let alert = UIAlertController(title: "", message: "비밀번호를 입력해 주세요", preferredStyle: .alert)
            
            
            alert.addAction(btnOk)
            present(alert, animated: true , completion: nil)
        }
        else if (txtPasswd.text == "" && txtID.text == ""){
            let alert = UIAlertController(title: "", message: "아이디와 비밀번호를 입력해 주세요", preferredStyle: .alert)
            
            alert.addAction(btnOk)
            present(alert, animated: true , completion: nil)
        }
        else {
            print("login Clicked")
//            if (txtID.text != userID || txtPasswd.text != userPasswd){
//                let alert = UIAlertController(title: "", message: "아이디와 비밀번호를 확인해 주세요", preferredStyle: .alert)
//                
//                alert.addAction(btnOk)
//                present(alert, animated: true , completion: nil)
//                txtID.text = ""
//                txtPasswd.text = ""
//            }
          //  if { // 로그인 성공 - present문 두개가 안먹는듯..
                let model = PostModel(self)
                let id = gsno(txtID.text)
                let pw = gsno(txtPasswd.text)
                model.login(id: id, pw: pw)
                
//                let alert = UIAlertController(title: "", message: "\(id)님 반갑습니다!", preferredStyle: .alert)
//                
//                alert.addAction(btnOk)
//                present(alert, animated: true , completion: nil)
            

            
//                let IDdata = txtID.text!
//                let PWdata = txtPasswd.text!
//                
//                if let tvc = storyboard?.instantiateViewController(withIdentifier: "ThirdVC") as? ThirdVC{
//                    tvc.IDdata = IDdata
//                    tvc.PWdata = PWdata
//                    present(tvc, animated: true)
              //  }
                
            }
        }
        
        
    }
    
    
    

