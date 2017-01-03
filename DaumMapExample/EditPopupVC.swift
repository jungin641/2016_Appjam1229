//
//  editPopup.swift
//  Huddle
//
//  Created by pro on 2017. 1. 3..
//  Copyright © 2017년 JunginYu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class EditPopupVC : UIViewController,NetworkCallback{
    
    func networkResult(resultData: Any, code: Int) {
        
        
    }
    @IBOutlet var profile : UIImageView!
    
    @IBOutlet var IDtxt : UILabel!
    
    @IBOutlet var nameTxt : UITextField!
    @IBOutlet var phTxt : UITextField!
    
    @IBOutlet var homeTxt : UITextField!
    @IBOutlet var workTxt : UITextField!
    
    let picker = UIImagePickerController()
    var userDefault = UserDefaults.standard
    var countLoaded = 0
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()//화면 누르면 키보드 내림
        
        if(countLoaded == 0){
            let imgurl = userDefault.string(forKey: "profile")
            profile?.imageFromUrl(imgurl, defaultImgPath: "human_big")
            profile?.roundedBorder()
        }
        else { }
        countLoaded+=1
        
        IDtxt?.text = userDefault.string(forKey: "id")
        nameTxt?.text = userDefault.string(forKey: "name")
        phTxt?.text = userDefault.string(forKey: "ph")
        homeTxt?.text = userDefault.string(forKey: "home")
        workTxt?.text = userDefault.string(forKey: "work")
        
        
    }
    
    
    @IBAction func backToSet(_ sender: Any) {
        let model = PostModel(self)
        
        let nameValue = gsno(nameTxt.text)
        let phValue = gsno(phTxt.text)
        let homeValue = gsno(homeTxt.text)
        let workValue = gsno(workTxt.text)
        
        
        //model.setMyInfo(id: (IDtxt?.text)!, name: (nameTxt?.text)!, ph: phTxt.text!, home: (homeTxt?.text)!, work: (workTxt?.text)!, profile: (profile?.image)!)
        
        self.userDefault.set(nameValue, forKey: "name")
        self.userDefault.set(phValue, forKey: "ph")
        self.userDefault.set(homeValue, forKey: "home")
        self.userDefault.set(workValue, forKey: "work")
        if let image = profile.image{
            let imageData = UIImageJPEGRepresentation(image, 0.5) // (데이터로 바꿔준 이미지, 품질)
            model.setMyInfo(name: nameValue, ph: phValue, home: homeValue, work: workValue, profileData: imageData)
        }

        presentingViewController?.viewDidLoad()
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func selectPhoto(_ sender: AnyObject) {
        // 새로운 화면창을 띄운다
        // 10.0부터 사진첩 열 때 허락 받아야함 -> Info.plist 오른쪽클릭 -> open as -> source code한 뒤 <key>와 <string> 입력 (딕셔너리형태라고 생각하면 됨. 키와 밸류, 키와 밸류 ...)
        present(picker, animated: true)
    }

    
    
    
    
}

extension EditPopupVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
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
        
        profile.image = newImage
        
        profile.roundedBorder()
        dismiss(animated: true, completion: nil) // present로 사진선택 들어왔기 때문에 dismiss 해주어야 함
    }
}

