//
//  Message.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let baseId:String
    let commentId:String
    let createdAt:String
    let message:String
    let senderUserId:String
    let senderUserName:String
    let feedDate:String?
}

struct BaseCommentResponse : Decodable {
    var items:[Comment]
    
    enum CodingKeys : String, CodingKey {
        case items = "items"
    }
}
