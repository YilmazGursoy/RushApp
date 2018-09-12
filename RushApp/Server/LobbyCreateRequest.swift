//
//  LobbyCreateRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class LobbyCreateRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.CreateLobbyRequest
    }
    
    func sendLobbyCreateRequest(lobbyName:String, address:String, numberOfNeededUser:Int, description:String, latitude:Double, longitude:Double, sender:User, game:Game?, platform:Platform, completionSuccess:@escaping (Lobby)->Void, completionFailed:@escaping ()->Void){
        guard let gameName = game?.name else {return}
        guard let gameid = game?.id else {return}
        guard let thumbImage = game?.thumbImage else {return}
        guard let normalImage = game?.normalImage else {return}
        
        let parameter:[String:Any] = ["name":lobbyName,
                                      "address":address,
                                      "description":description,
                                      "latitude":latitude,
                                      "longitude":longitude,
                                      "sender":["username":sender.username, "profilePic":sender.profilePicture],
                                      "game":["id":gameid, "name":gameName, "thumbImage": thumbImage, "normalImage":normalImage],
                                      "platform":platform.rawValue,
                                      "numberOfNeededUser":numberOfNeededUser]
        
        self.request(parameters: parameter) { (response:AnyObject?, lobby:Lobby?, error:Error?) in
            if lobby != nil {
                completionSuccess(lobby!)
            } else {
                completionFailed();
            }
        }
    }
}
