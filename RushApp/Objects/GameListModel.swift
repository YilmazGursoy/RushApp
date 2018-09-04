//
//  GameListModel.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: Int
    let name: String
    let picture: URL?
    var isActive:Bool? = false
    var thumbImage:String? = ""
    var normalImage:String? = ""
}

class GameListModel {
    var list: [Game] = []
}
