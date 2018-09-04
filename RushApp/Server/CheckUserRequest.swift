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
    
    func sendCheckUserRequest(completionBlock: @escaping (Any? ,Error?) -> Void) {
        
        
//        self.requestWith(functionName: lambdaName, andParameters: [:]) { (result, error) -> (Void) in
//
//            completionBlock(result, error)
//
//        }
    }
}
