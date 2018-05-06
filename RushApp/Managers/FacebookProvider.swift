//
//  FacebookProvider.swift
//  RushApp
//
//  Created by Most Wanted on 6.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import AWSCore
import AWSCognito
import Foundation
import FacebookCore

class FacebookProvider: NSObject, AWSIdentityProviderManager {
    func logins() -> AWSTask<NSDictionary> {
        if let token = AccessToken.current?.authenticationToken {
            return AWSTask(result: [AWSIdentityProviderFacebook:token])
        }
        return AWSTask(error:NSError(domain: "Facebook Login", code: -1 , userInfo: ["Facebook" : "No current Facebook access token"]))
    }
}
