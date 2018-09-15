//
//  GameProfile.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct GameProfile : Decodable {
    let platform:Int
    let url:String
    
    enum CodingKeys : String, CodingKey {
        case platform = "platform"
        case url      = "platformUrl"
    }
}
