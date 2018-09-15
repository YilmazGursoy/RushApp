//
//  AddRankOrUrlRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct AddRankOrUrlRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.AddURLRequset
    }
    
    func sendUrlRequest(platform:Int, url:String, successCompletion:@escaping ()->Void, failedCompletion:@escaping ()->Void){
        let parameter:[String:Any] = ["platform":platform,
                                      "url":url]
        
        self.request(parameters: parameter) { (response:AnyObject?, socialUrl:SocialURL?, error:Error?) in
            if response != nil {
                successCompletion()
            } else {
                failedCompletion()
            }
        }
    }
}
