//
//  JoinLobbyRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 20.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class JoinLobbyRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.JoinLobbyRequest
    }
    
    func sendRequest(lobbyId:String, userId:String, userName:String ,successCompletion:@escaping (Lobby)->Void, errorCompletion:@escaping ()->Void) {
        
        let parameters:[String:String] = ["id":lobbyId,
                                             "userId":userId,
                                             "newUserName":userName]
        
        self.request(parameters: parameters) { (response:AnyObject?, lobby:Lobby?, error:Error?) in
            if lobby != nil {
                successCompletion(lobby!)
            } else {
                errorCompletion()
            }
        }
    }
}
