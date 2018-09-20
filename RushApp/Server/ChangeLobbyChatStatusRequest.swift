//
//  ChangeLobbyChatStatusRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 21.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class ChangeLobbyChatStatusRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.ChangeLobbyChatStatus
    }
    
    func sendRequest(lobbyId:String, successCompletion:@escaping (Lobby)->Void, errorCompletion:@escaping ()->Void) {
        let parameters = ["id":lobbyId]
        
        self.request(parameters: parameters) { (response:AnyObject?, lobby:Lobby?, error:Error?) in
            if lobby != nil {
                successCompletion(lobby!)
            } else {
                errorCompletion()
            }
        }
    }
    
    
}
