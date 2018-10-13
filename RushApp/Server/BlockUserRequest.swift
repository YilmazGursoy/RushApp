//
//  BlockUserRequest.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class BlockUserRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.BlockUserRequest
    }
    
    func sendRequest(userId:String, username:String, successCompletion:@escaping (User)->Void, errorCompletion:@escaping ()->Void) {
        let parameters:[String:Any] = ["user":["username":username,"id":userId]]
        
        self.request(parameters: parameters) { (response:AnyObject?, currentUser:User?, error:Error?) in
            DispatchQueue.main.async {
                if currentUser != nil {
                    successCompletion(currentUser!)
                } else {
                    errorCompletion()
                }
            }
        }
    }
    
}
