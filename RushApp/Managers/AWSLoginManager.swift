//
//  AWSLoginManager.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSCognito
import AWSCognitoIdentityProvider

class AWSLoginManager {
    
    func login(withUsername username: String, andPassword password:String, withCompletionBlock completion:@escaping(AWSTask<AWSCognitoIdentityUserSession>)->Void) {
        
        AWSCredentialManager.shared.getUserPool { (pool) in
            
            pool.getUser().getSession(username, password: password, validationData: nil).continueWith(block: { (task) -> Any? in
                
                if task.error != nil {
                    if let error = task.error {
                        if let userInfo = error._userInfo {
                            if let userInfoType = userInfo["__type"] {
                                if userInfoType == "UserNotConfirmedException" {
                                    //TODO: Make this area dynamic open confirm view controller
                                    exit(0)
                                }
                            }
                        }
                    }
                    //MARK: Todo some error features
                    
                    completion(task)
                    
                } else {
                    
                 completion(task)
                    
                }
                return nil
            })
            
        }
        
    }
    
    
}
