//
//  SendLikeRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 26.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class SendLikeRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.LikeFeedRequest
    }
    
    func sendLikeFeedRequest(feedId:String, feedDate:Double, successCompletion:@escaping (User)->Void, errorCompletion:@escaping ()->Void) {
        let parameters:[String:Any] = ["feedId":feedId,
                          "feedDate":feedDate,
                          "username":Rush.shared.currentUser.username]
        
        self.request(parameters: parameters) { (response:AnyObject?, user:User?, error:Error?) in
            if user != nil {
                successCompletion(user!);
            } else {
                errorCompletion()
            }
        }
    }
    
}
