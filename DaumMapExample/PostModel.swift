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
                            
                            let info = data["info"]
                            self.userDefault.set(info["id"].int, forKey: "id")
                            self.userDefault.set(info["name"].string, forKey: "name")
                            self.userDefault.set(info["ph"].string, forKey: "ph")
                            self.userDefault.set(info["home"].string, forKey: "home")
                            self.userDefault.set(info["work"].string, forKey: "work")
                            self.userDefault.set(info["profile"].string, forKey: "profile")
                            self.userDefault.synchronize()
                            print("로그인 성공")
                            self.view.networkResult(resultData: 1, code: 1)
                        }
                        else if loginResult == "FAIL"{
                            print("로그인 실패 - 아이디 비밀번호 확인")
                            self.view.networkResult(resultData: 0, code: 0)
                        }
                        
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
                        print("\(idCheckResult)중복확인결과")
                        if idCheckResult == "SUCCESS" {
                            self.view.networkResult(resultData: "\(id)는 사용 가능합니다", code: 1)
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
    
    //사진회원가입
    func joinWithPhoto(id: String, pw: String,ph:String,name:String,work : String, imageData: Data?,home : String) {
        
        let url = "\(baseURL)/join/"
        
        let idData = id.data(using: .utf8)!
        let pwData = pw.data(using: .utf8)!
        let phData = ph.data(using: .utf8)!
        let nameData = name.data(using: .utf8)!
        let homeData = home.data(using: .utf8)!
        let workData = work.data(using: .utf8)!
        if imageData == nil {
        } else {
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(idData, withName:"id")
                    multipartFormData.append(pwData, withName:"pw")
                    multipartFormData.append(phData, withName:"ph")
                    multipartFormData.append(homeData, withName:"home")
                    multipartFormData.append(workData, withName:"work")
                    multipartFormData.append(nameData, withName:"name")
                    multipartFormData.append(imageData!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
            },
                to: url,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseData { res in
                            switch res.result {
                            case .success:
                                DispatchQueue.main.async(execute: {
                                    
                                    self.view.networkResult(resultData: "회원가입이 완료되었습니다.", code: 2)
                                    
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
                    }            })
        }
    }
    // 개인방 목록 가져오기
    func getPrivate() {
        let idValue = userDefault.string(forKey: "id")
        
        // let idValue = userDefault.string(forKey: "id")
        let params1 = ["id" : idValue]
        
        Alamofire.request("\(baseURL)/main", method: .post, parameters: params1, encoding: JSONEncoding.default).responseJSON()  { res in // 맨 끝의 인자가 함수면 클로저 사용 가능
            switch res.result {
            case .success :
                
                //                    meeting_id : int , //방 번호
                //                    is_open : int, (0: 비공개방, 1: 공개방)
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
                                participateNum: item["member"].int,
                                meeting_id :item["meeting_id"].int,
                                is_open : item["is_open"].int)
                            
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
    
    //회원정보수정
    func setMyInfo(name: String,ph:String, home:String,work : String, profileData : Data?){
        let idValue = userDefault.string(forKey: "id")
        let url = "\(baseURL)/main/edit/"
        
        let idData = idValue?.data(using: .utf8)!
        let phData = ph.data(using: .utf8)!
        let nameData = name.data(using: .utf8)!
        let homeData = home.data(using: .utf8)!
        let workData = work.data(using: .utf8)!
        if profileData == nil {
        } else {
            
            /// - parameter multipartFormData:       The closure used to append body parts to the `MultipartFormData`.
            /// - parameter encodingMemoryThreshold: The encoding memory threshold in bytes.
            ///                                      `multipartFormDataEncodingMemoryThreshold` by default.
            /// - parameter url:                     The URL.
            /// - parameter method:                  The HTTP method. `.post` by default.
            /// - parameter headers:                 The HTTP headers. `nil` by default.
            /// - parameter encodingCompletion:      The closure called when the `MultipartFormData` encoding is complete.
            
            Alamofire.upload(multipartFormData:  { multipartFormData in
                if let id = idData{
                    multipartFormData.append(id, withName:"id")
                    
                }
                multipartFormData.append(phData, withName:"ph")
                multipartFormData.append(homeData, withName:"home")
                multipartFormData.append(workData, withName:"work")
                multipartFormData.append(nameData, withName:"name")
                multipartFormData.append(profileData!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
            },
                             usingThreshold: 0,  to: url, method: .put, headers: nil,   encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseData { res in
                                        switch res.result {
                                        case .success:
                                            DispatchQueue.main.async(execute: {
                                                print("회원정보수정 완료")
                                            })
                                        case .failure(let err):
                                            print("upload Error : \(err)")
                                            DispatchQueue.main.async(execute: {
                                                
                                            })
                                        }
                                    }
                                case .failure(let err):
                                    print("network Error : \(err)")
                                    self.view.networkFailed()
                                }            })
            
        }
    }
    
    // 전화번호 동기화
    func sync(friends_list: [FriendVO]) {
        let id = userDefault.integer(forKey: "id")
        //  let id = "1"
        var friends = [[String : String]]()
        
        for friend in friends_list{
            let tempFriends_list = [
                "ph" : gsno(friend.ph),
                "name" : gsno(friend.name)
            ]
           
            friends.append(tempFriends_list)
        }
        
        let params = [
            "id" :  id,
            "friends_list" : friends
            ] as [String : Any]
        print(params)
        Alamofire.request("\(baseURL)/main/sync", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON() { res in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    
                    if let syncResult = data["result"].string{
                        print("\(syncResult)동기화성공")
                        if syncResult == "SUCCESS" {
                            // self.view.networkResult(resultData: "동기화성공 완료되었습니다.", code: 0)
                        }
                        else if syncResult == "FAIL" {
                            //  self.view.networkResult(resultData: "동기화 실패하였습니다..", code: 0)
                        }
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
    
    func exit(){
        let id = userDefault.integer(forKey: "my_meeting_id")
        Alamofire.request("\(baseURL)/room/exit/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(){ res in // 맨 끝의 인자가 함수면 클로저 사용 가능
            if let value = res.result.value {
                let data = JSON(value)
                if let idCheckResult = data["result"].string{
                    print("\(idCheckResult)성공")
                    if idCheckResult == "SUCCESS" {
                        self.view.networkResult(resultData: "방을 나갔습니다.", code: 5)
                    }
                    else if idCheckResult == "FAIL" {
                        print("나가기 실패")
                        self.view.networkResult(resultData: "방 나가기 실패! 통신오류!", code: 6)
                    }
                    
                }
            }
        }
    }
    
}
