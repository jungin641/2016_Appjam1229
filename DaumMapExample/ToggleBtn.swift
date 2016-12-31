//
//  UIToggleBtn.swift
//  seminar_1_hw_3
//
//  Created by YuJungin on 2016. 10. 10..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit

class ToggleBtn : UIButton{
    let btnPressed = 1
    let btnUnPressed = 0
    var Btnstate = 0
    var originColor : UIColor = UIColor.black
    
    //아래의 init 구문은 이 토글버튼이 초기화될 때 실행되는 구문입니다.
    //그대로 두시고 여러분들은 프로퍼티와 메소드만 직접 만들어주세요!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBtnClickEvent()
        Btnstate = btnPressed
        
    }
    
    init(){
        super.init(frame: CGRect.zero)
     
        setBtnClickEvent()
 
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBtnClickEvent()
    }
    
    //버튼에 클릭 이벤트를 달아주는 부분입니다.
    //여러분들이 @IBAction을 사용하여 정적으로 버튼에 이벤트를 달아주던 방식과 다르게 동적으로 버튼에 이벤트를 달아주는 방식입니다.
    //실습 때 여기까지 설명을 드리지 못했으니 아래의 코드를 참고해주시길 바랍니다!
    func setBtnClickEvent() {
        self.addTarget(self, action: #selector(ToggleBtn.touchBtn(_:)), for: UIControlEvents.touchUpInside)
           }
    
    func touchBtn(_ sender: ToggleBtn) {
      
        //토글 버튼을 클릭했을 때의 이벤트를 작성해줍니다.
        if(Btnstate == btnPressed){
            self.backgroundColor = UIColor.gray
            Btnstate = btnUnPressed
        }
        else if(Btnstate == btnUnPressed){
            //let originColor = self.backgroundColor
            self.backgroundColor = originColor
            Btnstate = btnPressed
        }
    }
    
}
