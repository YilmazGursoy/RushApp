
//
//  File.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 13.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UserAllLobbiesRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.GetUserAllLobbies
    }
    
    func sendLobbyRequest(userId:String?, successCompletionHandler:@escaping ([Lobby])->Void, errorCompletionHandler:@escaping ()->Void) {
        
        var parameters:[String:Any] = [:]
        if userId != nil {
            parameters["userId"] = userId
        }
        
        self.request(parameters: parameters) { (response:AnyObject?, lobbyList:[Lobby]?, error:Error?) in
            if lobbyList != nil{
                successCompletionHandler(lobbyList!)
            } else{
                errorCompletionHandler()
            }
        }
    }
}
