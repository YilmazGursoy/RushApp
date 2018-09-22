//
//  SendFollowRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 22.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class SendFollowingRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.UserAddRequest
    }
    
    func sendAddUserRequest(userId:String, username:String, responseSuccess:@escaping (User)->Void, responseFailed:@escaping ()->Void){
        let params = ["id":userId,
                      "username":username,
                      "senderUsername":Rush.shared.currentUser.username]
        
        self.request(parameters: params) { (response:AnyObject?, user:User?, error:Error?) in
            if user != nil {
                responseSuccess(user!)
            } else {
                responseFailed()
            }
        }
    }
}


class SendRemoveFollowingRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.UserRemoveRequest
    }
    
    func sendRemoveUserRequest(userId:String, responseSuccess:@escaping (User)->Void, responseFailed:@escaping ()->Void){
        let params = ["id":userId]
        
        self.request(parameters: params) { (response:AnyObject?, user:User?, error:Error?) in
            if user != nil {
                responseSuccess(user!)
            } else {
                responseFailed()
            }
        }
    }
    
}
