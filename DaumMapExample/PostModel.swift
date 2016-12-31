//
//  PostModel.swift
//  seminar_2_hw
//
//  Created by YuJungin on 2016. 12. 29..
//  Copyright © 2016년 jungining. All rights reserved.
//

import Alamofire
import SwiftyJSON

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
                        if loginResult == "SUCCESS" {
                            self.view.networkResult(resultData: "\(id)님 반갑습니다", code: 0)
                        }
                        else if loginResult == "FAIL"{
                            self.view.networkResult(resultData: "아이디와 비밀번호를 확인해주세요", code: 0)
                        }
                            
                    }
                   
                     let info = data["info"]
                      print(info)
                    
                      print(info["id"].string)
                      print(info["ph"].string)
                      print(info["name"].string)
                      print(info["profile"].string)
                      print(info["home"].string)
                      print(info["work"].string)
                    
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
                            print("\(idCheckResult)중복확인결과")
                            if idCheckResult == "SUCCESS" {
                                self.view.networkResult(resultData: "\(id)는 사용 가능합니다", code: 0)
                            }
                            else if idCheckResult == "FAIL" {
                                self.view.networkResult(resultData: "\(id)는 이미 사용중입니다.\n다른 아이디를 입력해주세요", code: 0)
                            }
                        
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
                    
                    
                    if let joinResult = data["result"].string{
                         print("\(joinResult)회원가입결과")
                        if joinResult == "SUCCESS" {
                            self.view.networkResult(resultData: "회원가입이 완료되었습니다.", code: 0)
                        }
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

