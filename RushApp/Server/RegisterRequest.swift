//
//  RegisterRequest.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

import AWSCognito
import AWSCognitoIdentityProvider

class RegisterRequest {
    
    func register(withUsername username:String, andPassword password:String, andEmail email:String, andNickname nickname:String, withCompletionHandler: @escaping(AWSTask<AWSCognitoIdentityUserPoolSignUpResponse>)->Void) {
        
        AWSCredentialManager.shared.configureUserPool()
        AWSCredentialManager.shared.configureFederatedIdentitiesForUserPool()
        
        let emailAtt    = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
        let nicknameAtt = AWSCognitoIdentityUserAttributeType(name: "nickname", value: nickname)
        
        let attributes:[AWSCognitoIdentityUserAttributeType] = [emailAtt, nicknameAtt]
        
        AWSCredentialManager.shared.getUserPool { (pool) in
            
            pool.signUp(username, password: password, userAttributes: attributes, validationData: nil).continueWith(block: { (response) -> Any? in
                
                withCompletionHandler(response)
                
                return nil
            })
            
        }
        
    }
    
    
}
