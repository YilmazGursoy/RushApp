//
//  User.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct User : Decodable {
    var userId:String
    var username:String
    var profilePicture:String
    var gameList:[Game]?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case username = "username"
        case gameList = "selectingGameIDs"
        case profilePicture = "profilePicture"
    }
    
}
