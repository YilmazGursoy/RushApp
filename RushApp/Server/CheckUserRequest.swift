//
//  CheckUserRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class CheckUserRequest: BaseRequest {
    func sendCheckUserRequest(completionBlock: @escaping (Any? ,Error?) -> Void) {
        let lambdaName = LambdaConstants.GetUser
        
        self.requestWith(functionName: lambdaName, andParameters: [:]) { (result, error) -> (Void) in
            
            completionBlock(result, error)
            
        }
    }
}
