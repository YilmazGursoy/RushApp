//
//  UpdateUserProfileRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 3.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UpdateUserProfileRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.UpdateUserProfileRequest
    }
    
    func sendUpdateRequest(name:String?, bio:String?, email:String?, phoneNumber:String?, gender:String?, age:Int?, successCompletion:@escaping (User)->Void, errorHandler:@escaping ()->Void) {
        
        var parameters = [String:Any]()
        if name != nil {
            parameters["fullName"] = name!
        }
        if bio != nil {
            parameters["bio"] = bio!
        }
        if email != nil {
            parameters["email"] = email!
        }
        if phoneNumber != nil {
            parameters["phoneNumber"] = phoneNumber!
        }
        if gender != nil {
            parameters["gender"] = gender!
        }
        if age != nil {
            parameters["age"] = age!
        }
        
        self.request(parameters: parameters) { (response:AnyObject?, user:User?, error:Error?) in
            if user != nil {
                successCompletion(user!)
            } else {
                errorHandler()
            }
        }
    }
    
}
