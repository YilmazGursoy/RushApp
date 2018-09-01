//
//  GetUserIdRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class GetUserIdRequest: BaseRequest {
    func sendGetUserIdRequest(completionBlock: @escaping (Any? ,Error?) -> Void) {
        let lambdaName = LambdaConstants.GetUserId
                
        self.requestWith(functionName: lambdaName, andParameters: [:]) { (result, error) -> (Void) in
            completionBlock(result, error)

        }
        
    }
}
