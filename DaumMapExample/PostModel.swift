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
    let userDefault = UserDefaults.standard
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
                            self.userDefault.set(id, forKey: "id")
                            self.userDefault.synchronize()
                            self.view.networkResult(resultData: 1, code: 0)
                        }
                        else if loginResult == "FAIL"{
                            self.view.networkResult(resultData: 0, code: 0)
                        }
                        
                    }
                    
                    let info = data["info"]
                    print(info)
                    
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
    func join(id: String, pw: String,ph:String,name:String,profileData:Data?) {
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
    //사진회원가입
    func joinWithPhoto(id: String, pw: String,ph:String,name:String,imageData: Data?) {
        
        let url = "\(baseURL)/join/"
        
        let idData = id.data(using: .utf8)!
        let pwData = pw.data(using: .utf8)!
        let phData = ph.data(using: .utf8)!
        let nameData = name.data(using: .utf8)!
        
        if imageData == nil {
        } else {
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData!, withName: "profile", fileName: "image.jpg", mimeType: "image/png")
                    multipartFormData.append(idData, withName:"id")
                    multipartFormData.append(pwData, withName:"pw")
                    multipartFormData.append(phData, withName:"ph")
                    multipartFormData.append(nameData, withName:"name")
                },
                to: url,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseData { res in
                            switch res.result {
                            case .success:
                                DispatchQueue.main.async(execute: {
                                    print("사진회원가입 성공")
                                    self.view.networkResult(resultData: "success", code: 0)
                                })
                            case .failure(let err):
                                print("upload Error : \(err)")
                                DispatchQueue.main.async(execute: {
                                    self.view.networkFailed()
                                })
                            }
                        }
                    case .failure(let err):
                        print("network Error : \(err)")
                        self.view.networkFailed()
                    }
            })
        }
    }
    // 개인방 목록 가져오기
    func getPrivate() {
        let id = userDefault.string(forKey: "id")
        let params1 = ["id" : gsno(id)]
  
        Alamofire.request("\(baseURL)/main", method: .post, parameters: params1, encoding: JSONEncoding.default).responseJSON()  { res in // 맨 끝의 인자가 함수면 클로저 사용 가능
            switch res.result {
            case .success :
                
                if let value = res.result.value {
                    let data = JSON(value)
                    var tempList = [GatheringVO]()
                    if let array = data["result"].array{
                        for item in array{
                            let gvo = GatheringVO(
                                profileImg: item["host_profile"].string,
                                title: item["title"].string,
                                name: item["host_name"].string,
                                where_fix: item["where_fix"].int,
                                when_fix: item["when_fix"].int,
                                participateNum: item["member"].int)
                            tempList.append(gvo)
                        }
                        
                        self.view.networkResult(resultData: tempList, code: 0)
                    }
                    
                    
                }
                break
                
            case .failure :
                self.view.networkFailed()
            }
        }
    }
    // 전화번호 동기화
    func sync(friends_list: [FriendVO]) {
        let id = userDefault.string(forKey: "id")
        var friends = [[String : String]]()
        
        for friend in friends_list{
            let tempFriends_list = [
            "ph" : gsno(friend.ph),
            "name" : gsno(friend.name)
            ]
            print(tempFriends_list)
            friends.append(tempFriends_list)
        }
      
        let params = [
            "id" :  gsno(id),
            "friends_list" : friends
        ] as [String : Any]
        
        Alamofire.request("\(baseURL)/main/sync", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    if let syncResult = data["result"].string{
                        print("\(syncResult)동기화성공")
//                        if joinResult == "SUCCESS" {
//                            self.view.networkResult(resultData: "회원가입이 완료되었습니다.", code: 0)
//                        }
                    }
                }
                
                break
            case .failure(let err) :
                print(err)
                print("동기화실패\(err)")
                self.view.networkFailed()
            }
            
        }
        
    }
    
}

