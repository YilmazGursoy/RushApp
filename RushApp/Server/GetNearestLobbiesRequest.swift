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
                
                if let blackList = Rush.shared.currentUser.blackList {
                    
                    var newLobbies = [Lobby]()
                    lobbyList?.forEach({ (lobby) in
                        do {
                            let isContain = try blackList.contains(where: { (simpleUser) -> Bool in
                                if simpleUser.user.id == lobby.sender.id {
                                    return true
                                } else {
                                    return false
                                }
                            })
                            
                            if isContain == false {
                                newLobbies.append(lobby)
                            }
                            
                        } catch{
                            
                        }
                        
                    })
                    successCompletion(newLobbies)
                    return
                }
                
                successCompletion(lobbyList!)
            } else {
                failedCompletion()
            }
        }
    }
}
