//
//  UserCreateRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UserCreateRequest: BaseRequest {
    
    func sendUserCreateRequest(selectingIds:[Int] ,completionBlock: @escaping (AnyObject?, Error?) -> Void) {
        let lambdaName = LambdaConstants.UserCreate
        let parameter = ["selectingGameIds":selectingIds]
        
        self.requestWith(functionName: lambdaName, andParameters: parameter) { (result, error) -> (Void) in
            
            completionBlock(result, error);
        }
    }
}
