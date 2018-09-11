//
//  UpdateFirebaseTokenRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 11.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UpdateFirebaseTokenRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.UpdateFirebaseToken
    }
    
    func sendUpdateFirebaseToken(completion:@escaping (AnyObject?,Bool)->Void) {
        if let firToken = Rush.shared.firToken {
            let parameter = ["firebaseToken":firToken]
            self.request(parameters: parameter) { (task:AnyObject?, result:User?, error:Error?) in
                completion(task, false)
            }
        } else {
            completion(nil, true)
        }
    }
}
