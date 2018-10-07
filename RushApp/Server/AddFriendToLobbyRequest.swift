//
//  AddFriendToLobbyRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class AddFriendToLobbyRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.AddFriendsToLobbyRequest
    }
    
    func sendFriendRequest(lobbyId:String, lobbyDate:Double, username:String, userId:String, users:[SimpleUser], successCompletion:@escaping ()->Void, errrCompletion:@escaping ()->Void) {
        var user = [String]()
        users.forEach { (simpleUser) in
            user.append(simpleUser.id)
        }
        
        let parameters:[String:Any] = ["lobbyId":lobbyId,
                                       "lobbyDate":lobbyDate,
                                       "username":username,
                                       "userId":userId,
                                       "users":user]
        
        self.request(parameters: parameters) { (response:AnyObject?, result:DefaultResponse?, error:Error?) in
            if response != nil {
                successCompletion()
            } else {
                errrCompletion()
            }
        }
        
    }
    
}
