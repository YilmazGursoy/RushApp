//
//  GetNearestLobbiesRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 14.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class GetNearestLobbiesRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.GetNearestLobbyRequest
    }
    
    func sendLobbyRequest(longitude:Double, latitude:Double, radius:Double, successCompletion:@escaping ([Lobby])->Void, failedCompletion:@escaping ()->Void) {
        
        let parameters:[String:Any] = ["longitude":longitude,
                          "latitude":latitude,
                          "radius":radius]
        
        self.request(parameters: parameters) { (response:AnyObject?, lobbyList:[Lobby]?, error:Error?) in
            
            if lobbyList != nil {
                successCompletion(lobbyList!)
            } else {
                failedCompletion()
            }
            
        }
    }
}
