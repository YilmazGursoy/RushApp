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
    
    func sendFeedRequest(completion:@escaping (BaseFeed?, Error?)->Void) {
        self.request(parameters: [:]) { (response:AnyObject?, feeds:BaseFeed?, error:Error?) in
            completion(feeds,error)
        }
    }
}
