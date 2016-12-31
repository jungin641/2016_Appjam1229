//
//  NetworkModel.swift
//  seminar_161126_1
//
//  Created by 유정인 on 2016. 11. 26..
//  Copyright © 2016년 SOPT. All rights reserved.
//


class NetworkModel {
    
    // aws EC2의 주소
    internal let baseURL = "http://52.79.137.94:3000"
    
    var view: NetworkCallback
    
    // 네트워크 모델을 만들 때 반드시 네트워크콜백 인자를 받아서 사용할 거다. (초기화구문)
    init(_ view: NetworkCallback) {
        self.view = view
    }
    
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
}
