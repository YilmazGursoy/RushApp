//
//  LoginRequest.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSCognito
import FacebookCore
import FacebookLogin
import AWSCognitoIdentityProvider

class LoginRequest {
    
    //MARK: Login with username, password
    func login(withUsername username: String, andPassword password:String, withCompletionBlock completion:@escaping(AWSTask<AWSCognitoIdentityUserSession>)->Void) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.functionLog(message: String(describing: self))
            pool.getUser().getSession(username, password: password, validationData: nil).continueWith(block: { (task) -> Any? in
                if task.result != nil {
                    RushLogger.successLog(message: "Login Success")
                    print(task.result!)
                    completion(task)
                } else {
                    RushLogger.errorLog(message: "Login Failed")
                    print(task.error!)
                    completion(task)
                }
                return nil
            })
            
        }
    }
    
    //MARK: Facebook login
    func facebookLogin(withTarget target:UIViewController, completion:@escaping(Bool)->Void, loadingStatus:@escaping()->Void){
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: target) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                completion(false)
                print(error)
            case .cancelled:
                completion(false)
                print("User cancelled login.")
            case .success( _, _, _):
                AWSCredentialManager.shared.loadUserCredentials()
                loadingStatus()
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    UserProfile.loadCurrent({ (profile) in
                        completion(true)
                    })
                })
            }
        }
    }
}
