//
//  SendDislikeRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 27.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class SendDislikeRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.DislikeFeedRequest
    }
    
    func sendDislikeFeedRequest(feedId:String, feedDate:Double, successCompletion:@escaping (User)->Void, errorCompletion:@escaping ()->Void) {
        let parameters:[String:Any] = ["feedId":feedId,
                                       "feedDate":feedDate]
        
        self.request(parameters: parameters) { (response:AnyObject?, user:User?, error:Error?) in
            if user != nil {
                successCompletion(user!);
            } else {
                errorCompletion()
            }
        }
    }
    
}
