//
//  AWSLoginManager.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSCognito
import AWSMobileClient
import AWSCognitoIdentityProvider
enum CurrentConfigurationType {
    case email
    case facebook
    case guest
}


class AWSCredentialManager {
    static let shared = AWSCredentialManager()
    var currentType:CurrentConfigurationType!
    
    func configureDefaultCredentials() {
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:CognitoConstants.cognitoFederatedIdentity_CLIENTREGION,
                                                                identityPoolId:CognitoConstants.cognitoFederatedIdentity_POOLID)
        
        let configuration = AWSServiceConfiguration(region:CognitoConstants.cognitoFederatedIdentity_CLIENTREGION,
                                                    credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        currentType = .guest
    }
    
    
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
        
        currentType = .email
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
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: CognitoConstants.cognitoUserPool_CLIENTREGION,
                                                               identityPoolId: CognitoConstants.cognitoUserPool_POOLID,
                                                               identityProviderManager: pool)
        let defaultServiceConfiguration = AWSServiceConfiguration(region: CognitoConstants.cognitoUserPool_CLIENTREGION,
                                                                  credentialsProvider: credentialProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
    }
    
}
