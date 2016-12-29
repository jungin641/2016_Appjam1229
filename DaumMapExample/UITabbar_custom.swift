//
//  UITabbar_custom.swift
//  Appjam_1
//
//  Created by YuJungin on 2016. 12. 27..
//  Copyright © 2016년 jungining. All rights reserved.
//

import UIKit
class UITabbar_custom: UITabBarController { //두번째 탭을 시작탭으로 지정하기 위해 커스텀
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1; //두번째 탭 시작탭으로 지정
    }

}
