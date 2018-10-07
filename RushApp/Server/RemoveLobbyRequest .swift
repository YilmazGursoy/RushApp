//
//  RemoveLobbyRequest .swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct RemoveLobbyRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.RemoveLobbyRequestsFromProfile
    }
    
    func sendRemoveRequets(lobbyId:String, successHandler:@escaping(User)->Void, errorHandler:@escaping ()->Void) {
        let parameters:[String:Any] = ["lobbyId":lobbyId]
        
        self.request(parameters: parameters) { (response:AnyObject?, user:User?, error:Error?) in
            DispatchQueue.main.async {
                if user != nil {
                    successHandler(user!)
                } else {
                    errorHandler()
                }
            }
        }
    }
}
