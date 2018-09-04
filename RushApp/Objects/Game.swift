//
//  GameListModel.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: String
    let name: String
    var thumbImage:String?
    var normalImage:String?
    var isActive:Bool?
}
