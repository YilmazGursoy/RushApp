//
//  LobbyRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 6.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class LobbyRequest: Request {
    
    var lambdaName: String? {
        return LambdaConstants.GetLobbies
    }
    
    func sendGameLobbyRequestWithoutParameters(completionBlock:@escaping ([Lobby]?,Error?)->Void) {
        
        self.request(parameters: ["":""]) { (response:AnyObject?, lobbies:[Lobby]?, error:Error?) in
            completionBlock(lobbies, error)
        }
        
    }
    
}
