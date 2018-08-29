//
//  UserCreateRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UserCreateRequest: BaseRequest {
    
    func sendUserCreateRequest(completionBlock: @escaping () -> Void) {
        let lambdaName = LambdaConstants.UserCreate
        let parameter = ["selectingGameIds":[1,2,3,4,5]]
        
        self.requestWith(functionName: lambdaName, andParameters: parameter) { (result, error) -> (Void) in
            
            completionBlock();
        }
    }
}
