//
//  Feed.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let id: String
    let picture: URL?
    let name: String
    let text: String
    let date: Date
    let sender: SimpleUser
    var numberOfLike: Int
    let numberOfShare: Int
    let numberOfComment:Int?
    var likers:[SimpleUser]?
    let title:String
}

struct BaseFeed :Codable {
    let feeds:[Feed]
    let count:Int?
    let scannedCount:Int?
    let lastEvaluatedKey:LastEvaluatedKey?
    
    enum CodingKeys : String, CodingKey {
        case feeds = "Items"
        case count = "Count"
        case scannedCount = "ScannedCount"
        case lastEvaluatedKey = "LastEvaluatedKey"
    }
}

struct LastEvaluatedKey : Codable {
    let id:String
    let date:Date
}

//MARK: JSON
/*
 {
    "id": "5b8e22854b4d06d70c2a3251",
    "picture": "https://picsum.photos/600/300/?random",
    "name": "Stein Garza",
    "text": "Veniam enim nisi nulla culpa dolore nostrud tempor ut. Officia deserunt ex amet ea ut ut veniam minim dolore sint. Voluptate tempor pariatur voluptate aliquip nostrud officia aliquip non velit ut velit non eu pariatur.\r\n",
    "date": "2018-03-14:26:23",
    "sender": {
      "id": 0,
      "username": "Courtney Ward",
      "profilePic": "https://picsum.photos/400/?random"
    },
    "numberOfLike": 838,
    "numberOfShare": 19
  }
 */
