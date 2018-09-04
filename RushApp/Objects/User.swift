//
//  User.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct User : Decodable {
    var username:String
    var profilePicture:String
    var gameList:[Game]?
}
