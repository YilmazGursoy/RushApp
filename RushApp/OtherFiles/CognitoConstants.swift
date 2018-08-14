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
    static let cognitoUserPool_POOLID                               = "eu-central-1_a0JEamQmJ"
    static let cognitoUserPool_CLIENTID                             = "5qo8aourer7prpc3i8vrpgern2"
    static let cognitoUserPool_CLIENTSECRET                         = "f94rin2ca1pq1t1d5v9orthn9fc7pggg642u481mot8b3p95b5o"
    static let cognitoUserPool_CLIENTREGION:AWSRegionType           = .EUCentral1
    static let cognitoUserPool_POOLCONFIG                           = "UserPool"
    
    //MARK: FederatedIdentity Ids
    static let cognitoFederatedIdentity_POOLID                      = "eu-central-1:0fa2062d-77b5-4ea9-a63d-2c86c12e8b7b"
    static let cognitoFederatedIdentity_CLIENTREGION:AWSRegionType  = .EUCentral1
    
    
}
