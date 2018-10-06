//
//  ChangeLobbyStatusRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 6.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class ChangeLobbyStatusRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.ChangeLobbyStatusRequest
    }
    
    func sendChangeLobbyStatus(lobbyId:String, newStatus:LobbyStatus, successCompletion:@escaping (Lobby)->Void, errorCompletion:@escaping ()->Void) {
        let params:[String:Any] = ["id":lobbyId,
                                   "status":newStatus.rawValue,
                                   "topicId":lobbyId.replacingOccurrences(of: ":", with: "")]
        
        self.request(parameters: params) { (response:AnyObject?, lobby:Lobby?, error:Error?) in
            DispatchQueue.main.async {
                if lobby != nil {
                    successCompletion(lobby!)
                } else {
                    errorCompletion()
                }
            }
        }
    }
}
