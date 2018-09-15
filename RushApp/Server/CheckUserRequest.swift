//
//  CheckUserRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class CheckUserRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.GetUser
    }
    
    func sendCheckUserRequest(userId:String?, completionBlock: @escaping (User? ,Error?) -> Void) {
        
        var parameters:[String:Any] = [:]
        
        if userId != nil {
            parameters["userId"] = userId!
        }
        
        self.request(parameters: parameters) { (result:AnyObject? ,response:User?, error:Error?)  in
            completionBlock(response, error)
        }
    }
}
