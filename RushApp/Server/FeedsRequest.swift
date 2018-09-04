//
//  FeedsRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class FeedsRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.GetFeeds
    }
    
    func sendFeedRequest(completion:@escaping ([Feed]?, Error?)->Void) {
        self.request(parameters: [:]) { (response:AnyObject?, feeds:[Feed]?, error:Error?) in
            completion(feeds,error)
        }
    }
}
