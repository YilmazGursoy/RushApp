//
//  UserCreateRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UserCreateRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.UserCreate
    }
    
    
    func sendUserCreateRequest(selectingIds:[Int], username:String ,completionBlock: @escaping (AnyObject?, Error?) -> Void) {
        
        let parameter = ["selectingGameIds":selectingIds,"username":username] as [String : Any]
        
//        self.requestWith(functionName: lambdaName, andParameters: parameter) { (result, error) -> (Void) in
//            
//            completionBlock(result, error);
//        }
    }
}
