//
//  BlockUser.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct BlockUser: Codable {
    var user:SimpleUser
    var blockerId:String
}
