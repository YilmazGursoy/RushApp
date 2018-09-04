//
//  UserCreateRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class UserCreateRequest: Request {
    var lambdaName: String? {
        return LambdaConstants.UserCreate
    }
    
    
    func sendUserCreateRequest(games:[Game], username:String ,completionBlock: @escaping (AnyObject?, Error?) -> Void) {
        
        var gamesArray:[[String:String]] = []
        
        games.forEach { (game) in
            gamesArray.append(["id":game.id,"name":game.name,"thumbImage":game.thumbImage!, "normalImage":game.normalImage!])
        }
        
        let parameter = ["selectingGameIds":gamesArray,"username":username] as [String : Any]
        
        self.request(parameters: parameter) { (result:AnyObject? ,response:DefaultResponse?, error:Error?) in
            if error != nil {
                completionBlock(nil,error)
            } else {
                completionBlock(nil,nil)
            }
            
        }
    }
    
}

/*
 

 let id: String
 let name: String
 var thumbImage:String?
 var normalImage:String?
 var isActive:Bool? = false
 
 */
