//
//  GetFeedByIdRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 6.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class GetFeedByIdRequest: Request {
    
    var lambdaName: String? {
        return LambdaConstants.GetFeedByIdRequest
    }
    
    func sendFeedRequest(id:String, date:Double, successCompletion:@escaping (Feed)->Void, errorCompletion:@escaping ()->Void) {
        let params:[String:Any] = ["id":id,
                      "date":date]
        self.request(parameters: params) { (response:AnyObject?, feed:Feed?, error:Error?) in
            
            if feed != nil {
                successCompletion(feed!)
            } else {
                errorCompletion()
            }
        }
        
    }
    
}
