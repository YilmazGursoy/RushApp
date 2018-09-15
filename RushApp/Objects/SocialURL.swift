//
//  SocialURL.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct SocialURL : Decodable {
    let url:String
    let platform:Int
    
    enum CodingKeys : String, CodingKey {
        case url = "url"
        case platform = "platform"
    }
}
