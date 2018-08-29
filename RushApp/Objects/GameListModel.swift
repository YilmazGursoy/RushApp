//
//  GameListModel.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class Game: Decodable {
    var id : Int?
    var name:String?
    var thumbImage:String?
    var normalImage:String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "name"
        case thumbImage = "thumbImage"
        case normalImage = "normalImage"
    }
}

class GameListModel: Decodable {
    var list: [Game]?
}
