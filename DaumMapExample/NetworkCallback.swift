//
//  NetworkCallback.swift
//  seminar_161126_1
//
//  Created by 최윤주 on 2016. 11. 26..
//  Copyright © 2016년 SOPT. All rights reserved.
//

protocol NetworkCallback {
    func networkResult(resultData: Any, code: Int)
    func networkFailed()
}
