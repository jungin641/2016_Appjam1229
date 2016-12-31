//
//  PostModel.swift
//  seminar_2_hw
//
//  Created by YuJungin on 2016. 12. 29..
//  Copyright © 2016년 jungining. All rights reserved.
//


import SwiftyJSON
import Alamofire

// 모델을 만들어서 뷰와 연동한 상황!!
class PostModel: NetworkModel {
    // 로그인 하기
    func login(id: String, pw: String) {
        let params = [
            "id" : id,
            "pw" : pw
        ]
        
        Alamofire.request("\(baseURL)/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    
                    if let loginResult = data["result"].string{
                        
                        self.view.networkResult(resultData: "\(loginResult)", code: 0)
                        print("로그인결과 \(loginResult)")
                    }
                    
                    
                }
                break
            case .failure(let err) :
                print(err)
                print("로그인 실패")
                self.view.networkFailed()
            }
            
        }
    }
    
    // 아이디 중복확인
    func checkID(id: String) {
        Alamofire.request("\(baseURL)/join/\(id)").responseJSON()  { res in // 맨 끝의 인자가 함수면 클로저 사용 가능
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    
                    if let idCheckResult = data["result"].string{
                         self.view.networkResult(resultData: "\(idCheckResult)", code: 0)
                        print("중복확인결과 \(idCheckResult)")
                    }

                }
                break
                
            case .failure(let err) :
                print(err)
                self.view.networkFailed()
            }
        }
    }
    // 회원가입
    func join(id: String, pw: String,ph:String,name:String) {
        let params = [
            "id" : id,
            "pw" : pw,
            "ph" : ph,
            "name" : name
        ]
        
        Alamofire.request("\(baseURL)/join", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    
                    if let loginResult = data["result"].string{
                        
                        self.view.networkResult(resultData: "\(loginResult)", code: 0)
                        print("로그인결과 \(loginResult)")
                    }
                    
                    
                }

                break
            case .failure(let err) :
                print(err)
                print("회원가입실패\(err)")
                self.view.networkFailed()
            }
            
        }

    }
}

