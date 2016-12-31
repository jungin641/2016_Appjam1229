//
//  ToggleButton.swift
//  seminar_1st_hw3
//
//  Created by  noldam on 2016. 10. 7..
//  Copyright © 2016년 SOPT. All rights reserved.
//

import UIKit

//뷰컨트롤러와 스토리보드 화면을 커넥션해줄때 아이덴티티 인스펙터에서 클래스를 입력해준거 기억나시죠?
//마찬가지로 여러분이 버튼을 만들고 이를 토글버튼으로 사용하고 싶다면 아이덴티티 인스펙터에서 ToggleButton을 class로 설정해주셔야 합니다.
class ToggleImageBtn : ToggleBtn{
    
    var selectedImage : UIImage = UIImage(named: "icon.png")!
    var unSelectedImage : UIImage = UIImage(named: "icon.png")!

    override func setBtnClickEvent() {
        //버튼같이 클릭이 가능한 객체에 한해서 제공하는 addTarget 메소드
        self.addTarget(self, action: #selector(ToggleImageBtn.touchBtn2(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func touchBtn2(_ sender: ToggleImageBtn?) {
        if(Btnstate == btnPressed){
            self.setBackgroundImage(selectedImage, for: UIControlState())
            Btnstate = btnUnPressed
        }
        else if(Btnstate == btnUnPressed){
            self.setBackgroundImage(unSelectedImage, for: UIControlState())
            Btnstate = btnPressed
        }

    }
    func setBtnClickedImg (clickedImage: UIImage){
        selectedImage = clickedImage
           }
    
    func setBtnUnClickedImg (unClickedImage: UIImage){
        unSelectedImage = unClickedImage
        
    }
}
