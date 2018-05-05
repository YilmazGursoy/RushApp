//
//  CognitoConstants.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSCognito

struct CognitoConstants {
    
    //MARK: UserPool Ids
    static let cognitoUserPool_POOLID                               = "eu-central-1_DUOLAxgXK"
    static let cognitoUserPool_CLIENTID                             = "1h2opv9q6pi68he85asjenjb1r"
    static let cognitoUserPool_CLIENTSECRET                         = "1v9hmib6ovk12ove5uh6rtm1b23tpkv89lvpicl3od8bl3bo4a65"
    static let cognitoUserPool_CLIENTREGION:AWSRegionType           = .EUCentral1
    static let cognitoUserPool_POOLCONFIG                           = "UserPool"
    
    //MARK: FederatedIdentity Ids
    static let cognitoFederatedIdentity_POOLID                      = "eu-central-1:0fa2062d-77b5-4ea9-a63d-2c86c12e8b7b"
    static let cognitoFederatedIdentity_CLIENTREGION:AWSRegionType  = .EUCentral1
    
    
}
