//
//  AWSLoginManager.swift
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

enum CurrentConfigurationType {
    case email
    case facebook
    case guest
}

class AWSCredentialManager {
    static let shared = AWSCredentialManager()
    var currentType:CurrentConfigurationType!
    var currentCredential:AWSCognitoCredentialsProvider!
    
    //MARK: UserPool Configuration
    func configureUserPool(){
        let serviceConfiguration = AWSServiceConfiguration(region: CognitoConstants.cognitoUserPool_CLIENTREGION,
                                                           credentialsProvider: nil)
        
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoConstants.cognitoUserPool_CLIENTID,
                                                                        clientSecret: CognitoConstants.cognitoUserPool_CLIENTSECRET,
                                                                        poolId: CognitoConstants.cognitoUserPool_POOLID)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration,
                                            userPoolConfiguration: poolConfiguration,
                                            forKey: CognitoConstants.cognitoUserPool_POOLCONFIG)
    }
    
    func getUserPool(pool:@escaping(AWSCognitoIdentityUserPool)->Void) {
        
        if currentType != .email {
            configureUserPool()
            configureFederatedIdentitiesForUserPool()
        }
        
        let currentUserPool = AWSCognitoIdentityUserPool(forKey: CognitoConstants.cognitoUserPool_POOLCONFIG)
        pool(currentUserPool)
    }
    
    //MARK: Fedarated Identities Configuration
    func configureFederatedIdentitiesForUserPool(){
        let pool = AWSCognitoIdentityUserPool(forKey: CognitoConstants.cognitoUserPool_POOLCONFIG)
        currentType = .email
        self.cognitoFederatedIdentitySetup(withProvider: pool)
        RushLogger.credentialLog(message: "UserPool")
    }
    
    func configureFederatedIdentitiesForFacebook(){
        let provider = FacebookProvider()
        currentType = .facebook
        self.cognitoFederatedIdentitySetup(withProvider: provider)
        RushLogger.credentialLog(message: "Facebook")
    }
    
    fileprivate func cognitoFederatedIdentitySetup(withProvider provider:AWSIdentityProviderManager){
        
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: CognitoConstants.cognitoUserPool_CLIENTREGION,
                                                               identityPoolId: CognitoConstants.cognitoFederatedIdentity_POOLID,
                                                               identityProviderManager: provider)
        
        credentialProvider.credentials().continueWith { (credentials) -> Any? in
            return nil
        }
        
        let defaultServiceConfiguration = AWSServiceConfiguration(region: CognitoConstants.cognitoUserPool_CLIENTREGION,
                                                                  credentialsProvider: credentialProvider)
        currentCredential = credentialProvider
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
        
    }
    
    func logout(){
        if let _ = AccessToken.current?.authenticationToken {
            facebookLogout()
        } else {
            getUserPool { (pool) in
                if ( pool.currentUser()?.isSignedIn == true ) {
                    self.userpoolLogout()
                } else {
                    RushLogger.errorLog(message: "User Not Logged In")
                }
            }
        }
    }
    
    fileprivate func userpoolLogout(){
        if currentCredential != nil {
            let pool = AWSCognitoIdentityUserPool(forKey: CognitoConstants.cognitoUserPool_POOLCONFIG)
            pool.currentUser()?.signOutAndClearLastKnownUser()
            pool.clearLastKnownUser()
            currentCredential.clearKeychain()
            currentCredential.clearCredentials()
        }
    }
    
    fileprivate func facebookLogout(){
        if currentCredential != nil {
            let loginManager = LoginManager()
            loginManager.logOut()
            currentCredential.clearKeychain()
            currentCredential.clearCredentials()
        }
    }
    
    func isUserLoggedIn(completion:@escaping(_ isUserLogin:Bool)->Void){
        if let _ = AccessToken.current?.authenticationToken {
            completion(true)
        } else {
            getUserPool { (pool) in
                if ( pool.currentUser()?.isSignedIn == true ) {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    
    
}
